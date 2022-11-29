defmodule Aoc21Test.Two do
  use ExUnit.Case

  test "two" do
    alias Aoc21.Two.Ship, as: Ship
    alias Aoc21.Two.Move, as: Move

    ship =
      %Ship{}
      |> Move.forward(5)
      |> Move.down(5)
      |> Move.forward(8)
      |> Move.up(3)
      |> Move.down(8)
      |> Move.forward(2)

    assert ship.position * ship.depth == 150
  end
end
