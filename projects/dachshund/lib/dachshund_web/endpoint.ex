defmodule DachshundWeb.Endpoint do
  use Plug.Router
  import Plug.Conn
  alias DachshundWeb.{WhatsappController, SMSController}

  plug(:match)
  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json, :poison],
    json_encoder: Poison,
    json_decoder: Poison
  )

  plug(:dispatch)

  forward("/api/v1/whatsapp", to: WhatsappController)
  forward("/api/v1/sms", to: SMSController)

  match _ do
    send_resp(conn, :not_found, "Oops!")
  end
end
