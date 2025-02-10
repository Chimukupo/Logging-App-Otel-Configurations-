# General application configuration
import Config

config :logging_app,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :logging_app, LoggingAppWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: LoggingAppWeb.ErrorHTML, json: LoggingAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LoggingApp.PubSub,
  live_view: [signing_salt: "+wp14kM6"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :logging_app, LoggingApp.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  logging_app: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  logging_app: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure log levels and file destinations
config :logger,
  backends: [
    {LoggerFileBackend, :info_log},
    {LoggerFileBackend, :error_log},
    {LoggerFileBackend, :warn_log}
  ]

config :logger, :info_log,
  path: "C:/Users/Cyber Comp Tech/Documents/Logs/logging_app/info.log",
  level: :info

config :logger, :error_log,
  path: "C:/Users/Cyber Comp Tech/Documents/Logs/logging_app/error.log",
  level: :error

config :logger, :warn_log,
  path: "C:/Users/Cyber Comp Tech/Documents/Logs/logging_app/warn.log",
  level: :warn

  config :opentelemetry,
  traces_exporter: :otlp

# Opentelemetry configurations
config :opentelemetry_exporter,
  otlp_protocol: :http_protobuf,
  # otlp_endpoint: "http://localhost:4317"
  otlp_endpoint: "http://localhost:4318"


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
