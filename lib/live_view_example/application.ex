defmodule LiveViewExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveViewExample.Count,
      LiveViewExample.Gauge,
      # Start the Telemetry supervisor
      LiveViewExampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveViewExample.PubSub},
      LiveViewExample.Presence,
      # Start Finch
      {Finch, name: LiveViewExample.Finch},
      # Start the Endpoint (http/https)
      LiveViewExampleWeb.Endpoint
      # Start a worker by calling: LiveViewExample.Worker.start_link(arg)
      # {LiveViewExample.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
