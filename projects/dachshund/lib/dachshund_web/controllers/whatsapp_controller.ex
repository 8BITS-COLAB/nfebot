defmodule DachshundWeb.WhatsappController do
  use Plug.Router
  import Plug.Conn
  alias Malamute.Whatsapp.Supervisor
  require Logger

  plug(:match)
  plug(:dispatch)

  post "/messages" do
    Logger.info(conn.body_params)
    send_resp(conn, :created, "")
  end

  get "/messages" do
    send_resp(conn, :ok, Poison.encode!(Supervisor.list()))
  end

  post "/callback" do
    Logger.info(conn.body_params)
    send_resp(conn, :no_content, "")
  end
end
