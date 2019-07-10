defmodule Igdb.MixProject do
  use Mix.Project

  def project do
    [
      app: :igdb,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # Docs
      name: "Igdb",
      source_url: "https://github.com/alexanderttalvarez/igdb",
      docs: [
        main: "Igdb", # The main page in the docs
        extras: ["README.md"]
      ]
    ]
  end

  defp description do
    """
    A library for retrieving videogames data from the IGDB API V.3.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Alexander TT"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/alexanderttalvarez/igdb"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.4"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
