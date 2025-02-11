defmodule LoggingAppWeb.PageController do
  use LoggingAppWeb, :controller
  require OpenTelemetry.Tracer, as: Tracer
  require Logger

  # def home(conn, _params) do
  #   Logger.info("Info: Page loaded successfully")
  #   Logger.warning("Warning: This is a test warning log")
  #   Logger.error("Error: Something went wrong")

  #   text(conn, "Logs generated! Check your log files.")
  #   # render(conn, :home, layout: false)
  # end

  def home(conn, _params) do
    Tracer.with_span "index_operation" do
      # The logger will automatically include trace context
      Logger.info("Starting index operation")

      # Add custom attributes to the current span
      Tracer.set_attributes([
        {"custom.attribute", "value"},
        {"operation.type", "home"}
      ])

      # Add events to the span
      Tracer.add_event("operation_milestone", [
        {"milestone.type", "checkpoint"},
        {"milestone.timestamp", System.system_time(:millisecond)}
      ])

      # render(conn, :home)
      text(conn, "Logs generated✅! Check your log files.")
    end
  end
end
