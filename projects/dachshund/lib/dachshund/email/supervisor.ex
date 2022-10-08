defmodule Malamute.Email.Supervisor do
  use DynamicSupervisor
  alias Malamute.Email.Server

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def deliver({template, context}) do
    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, Server)
    Server.deliver(pid, {template, context})
  end
end
