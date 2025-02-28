defmodule LoggingApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :logging_app,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {LoggingApp.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.18"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.1.1",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.26"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, "~> 1.5"},
      # ====== ====== Opentelemetry Dependencies ====== ======
        {:opentelemetry, "~> 1.5"},
        {:opentelemetry_api, "~> 1.4"},
        {:opentelemetry_exporter, "~> 1.8"},
        {:opentelemetry_phoenix, "~> 2.0"},
        {:opentelemetry_zipkin, "~> 1.1"},
        {:opentelemetry_telemetry, "~> 1.1"},
        {:opentelemetry_function, "~> 0.1.0"},
        {:opentelemetry_logger_metadata, "~> 0.1.0"},
        {:opentelemetry_semantic_conventions, "~> 1.27"},
        {:logger_file_backend, "~> 0.0.14"},
        {:tracing, "~> 0.2.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind logging_app", "esbuild logging_app"],
      "assets.deploy": [
        "tailwind logging_app --minify",
        "esbuild logging_app --minify",
        "phx.digest"
      ]
    ]
  end
end
