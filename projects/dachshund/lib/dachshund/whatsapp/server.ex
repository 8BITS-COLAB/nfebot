defmodule Malamute.Whatsapp.Server do
  use GenServer, restart: :temporary
  @twilio_phone "whatsapp:+14155238886"

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def push(pid, {to, body}) do
    GenServer.cast(pid, {:push, to, body})
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  @impl true
  def init(:ok), do: {:ok, []}

  @impl true
  def handle_cast({:push, to, body}, _state) do
    ExTwilio.Message.create(from: @twilio_phone, to: "whatsapp:#{to}", body: body)

    {:noreply, []}
  end

  @impl true
  def handle_call(:list, _from, _state) do
    {:reply, ExTwilio.Message.all(from: @twilio_phone), []}
  end
end
