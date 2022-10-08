defmodule Malamute.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Malamute.SMS.Supervisor,
      Malamute.Whatsapp.Supervisor,
      Malamute.Email.Supervisor,
      {Plug.Cowboy, plug: DachshundWeb.Endpoint, scheme: :http, options: [port: 4000]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Malamute.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
