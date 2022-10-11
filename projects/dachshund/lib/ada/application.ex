defmodule ADA.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: :ada},
      {Cachex, name: :context},
      {Plug.Cowboy, plug: ADAWeb.Endpoint, scheme: :http, options: [port: 3001]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ADA.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
