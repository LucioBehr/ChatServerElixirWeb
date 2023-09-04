defmodule MultiUserChatServerPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MultiUserChatServerPhoenixWeb.Telemetry,
      MultiUserChatServerPhoenix.Repo,
      {Phoenix.PubSub, name: MultiUserChatServerPhoenix.PubSub},
      {Finch, name: MultiUserChatServerPhoenix.Finch},
      MultiUserChatServerPhoenixWeb.Endpoint,
      {MultiUserChatServerPhoenix, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MultiUserChatServerPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MultiUserChatServerPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
