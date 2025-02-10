defmodule LoggingAppWeb.PageController do
  use LoggingAppWeb, :controller
  require Logger

  def home(conn, _params) do
    Logger.info("Info: Page loaded successfully")
    Logger.warning("Warning: This is a test warning log")
    Logger.error("Error: Something went wrong")

    text(conn, "Logs generated! Check your log files.")
    # render(conn, :home, layout: false)
  end
end
