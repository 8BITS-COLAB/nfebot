defmodule ADAWeb.WhatsappController do
  use Plug.Router
  import Plug.Conn
  require Logger

  alias ADA.{Assistant, DecisionMaker}

  plug(:match)
  plug(:dispatch)

  post "/messages" do
    %{"From" => from, "To" => to, "Body" => body} = conn.body_params

    {text, context} =
      case Cachex.get!(:context, from) do
        nil ->
          {text, context} = Assistant.message({:text, body, %{}})
          Cachex.set!(:context, from, context)
          Cachex.expire!(:context, from, :timer.minutes(10))

          {text, context}

        context ->
          {text, context} = Assistant.message({:text, body, context})
          Cachex.set!(:context, from, context)
          Cachex.expire!(:context, from, :timer.minutes(10))
          {text, context}
      end

    Task.Supervisor.start_child(:ada, fn ->
      context = DecisionMaker.make(context)
      Cachex.set!(:context, from, context)
      Cachex.expire!(:context, from, :timer.minutes(10))
    end)

    Task.Supervisor.start_child(:ada, fn ->
      ExTwilio.Message.create(to: from, from: to, body: text)
    end)

    send_resp(conn, :no_content, "")
  end

  post "/callback" do
    %{"MessageSid" => message_sid, "MessageStatus" => message_status} = conn.body_params

    Logger.info("message #{message_sid} #{message_status}")

    send_resp(conn, :no_content, "")
  end
end
