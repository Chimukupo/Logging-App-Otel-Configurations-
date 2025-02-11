defmodule LoggingApp.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LoggingAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:logging_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LoggingApp.PubSub},
      {Finch, name: LoggingApp.Finch},
      LoggingAppWeb.Endpoint
    ]
    opts = [strategy: :one_for_one, name: LoggingApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    LoggingAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
