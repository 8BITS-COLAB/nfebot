defmodule DachshundTest do
  use ExUnit.Case
  doctest Malamute

  test "greets the world" do
    assert Malamute.hello() == :world
  end
end
