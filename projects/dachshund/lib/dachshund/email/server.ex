defmodule Malamute.Email.Server do
  use GenServer
  require Logger
  alias Malamute.Email.{Builder, Mailer}

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def deliver(pid, {template, context}) do
    GenServer.cast(pid, {:deliver, template, context})
  end

  @impl true
  def init(:ok), do: {:ok, []}

  @impl true
  def handle_cast({:deliver, template, context}, _state) do
    {template, context}
    |> Builder.build()
    |> Mailer.deliver_now!()

    {:noreply, []}
  end
end
