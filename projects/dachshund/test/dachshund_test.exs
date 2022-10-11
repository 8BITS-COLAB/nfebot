defmodule ADATest do
  use ExUnit.Case
  doctest ADA

  test "greets the world" do
    assert ADA.hello() == :world
  end
end
