defmodule SwissSchema.MixProject do
  use Mix.Project

  def project do
    [
      app: :swiss_schema,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

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
      {:mix_test_watch, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end
end
