defmodule DachshundWeb.SMSController do
  use Plug.Router
  import Plug.Conn
  alias Malamute.SMS.Supervisor

  plug(:match)
  plug(:dispatch)

  get "/messages" do
    send_resp(conn, :ok, Poison.encode!(Supervisor.list()))
  end
end
