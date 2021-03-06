defmodule SimplePool.Mixfile do
  use Mix.Project

  def project do
    [
      app: :simple_pool,
      version: "0.1.4",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    """
    A simple library to make inline worker pools easy
    """
  end

  defp package do
    [
      name: :simple_pool,
      maintainers: ["Andrew Cottage"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/andrewcottage/simple_pool"
        # "Docs" => "http://ericmj.github.io/postgrex/"
      }
    ]
  end
end
