defmodule Malamute.Whatsapp.Supervisor do
  use DynamicSupervisor
  alias Malamute.Whatsapp.Server

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def push({to, body}) do
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, Server)
    Server.push(pid, {to, body})
  end

  def list() do
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, Server)
    Server.list(pid)
  end
end
