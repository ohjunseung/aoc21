defmodule Aoc21Test.Six do
  use ExUnit.Case

  test "simulate" do
    initial = [3, 4, 3, 1, 2]

    assert Aoc21.Six.simulate(initial, 80) == 5934
  end
end
