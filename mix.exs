defmodule SwissSchema.MixProject do
  use Mix.Project

  @version "0.3.2"
  @source_url "https://github.com/joeljuca/swiss_schema"

  def project do
    [
      app: :swiss_schema,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),

      # Hex
      package: package(),
      version: @version,
      description: "A Swiss Army knife for your Ecto schemas",
      source_url: @source_url,
      docs: docs()
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env) when env in [:dev, :test], do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},

      # dev/test
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ecto_sqlite3, "~> 0.10.3", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.30.1", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "SwissSchema"
    ]
  end
end
