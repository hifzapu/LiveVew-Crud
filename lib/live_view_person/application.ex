defmodule LiveViewPerson.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveViewPersonWeb.Telemetry,
      LiveViewPerson.Repo,
      {DNSCluster, query: Application.get_env(:live_view_person, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveViewPerson.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveViewPerson.Finch},
      # Start a worker by calling: LiveViewPerson.Worker.start_link(arg)
      # {LiveViewPerson.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveViewPersonWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewPerson.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewPersonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
