defmodule SimplePool do
  @moduledoc """
  Documentation for SimplePool.
  """

  @doc """
  Takes an enumerable and for every chuck it maps over the collection
  and performs the given function asynchronously
      iex(1)> SimplePool.chunk_async([1,2,3,4,5,6,7,8,9,10], fn(n) -> n * 2 end, 3)
      [2, 4, 6, 8, 10, 12, 14, 16, 18]
  """
  @spec chunk_async(Enum.t, (any() -> any()), integer()) :: list()
  def chunk_async(enumerable, fun, size) do
    chunked = Enum.chunk(enumerable, size)
    do_perform(chunked, fun, [])
  end

  #####################
  # Private Functions #
  #####################

  defp do_perform([], _fun, acc), do: acc |> List.flatten() |> Enum.reverse()
  defp do_perform([chunk | rest], fun, acc) do
    tasks = do_async(chunk, fun, [])
    returns = wait_for(tasks, [])
    do_perform(rest, fun, [returns|acc])
  end

  defp do_async([], _fun, acc), do: acc
  defp do_async([item|rest], fun, acc) do
    task = Task.async(fn -> fun.(item) end)
    do_async(rest, fun, [task|acc])
  end

  defp wait_for([], return), do: Enum.reverse(return)
  defp wait_for([task|rest], return) do
    value = Task.await(task)
    wait_for(rest, [value|return])
  end
end
