defmodule LoggingApp.OtelTracer do
  @behaviour Plug
  require OpenTelemetry.Tracer
  require Logger

  def init(opts), do: opts  # This function is required but not used here

  def call(conn, _opts) do

    # Start a new OpenTelemetry span for the HTTP request
    OpenTelemetry.Tracer.with_span "http_request" do
      Logger.info("Tracing request: #{conn.method} #{conn.request_path}")

      OpenTelemetry.Tracer.with_span "http_request", attributes: %{
        "service.name" => "logging_app",
        "http.method" => conn.method,
        "http.target" => conn.request_path
      } do
        Logger.info("✅ Tracing request: #{conn.method} #{conn.request_path}")
      end

    end

    conn  # Always return the connection
  end
end
