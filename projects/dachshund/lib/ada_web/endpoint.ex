defmodule ADAWeb.Endpoint do
  use Plug.Router
  import Plug.Conn
  alias ADAWeb.WhatsappController

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :json, :poison],
    pass: ["*/*"],
    json_encoder: Poison,
    json_decoder: Poison
  )

  plug(Plug.Logger)
  plug(:dispatch)

  forward("/api/v1/whatsapp", to: WhatsappController)

  match _ do
    send_resp(conn, :not_found, "Oops!")
  end
end
