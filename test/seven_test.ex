defmodule Aoc21Test.Seven do
  use ExUnit.Case

  test "run" do
    input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
    assert Aoc21.Seven.run(input) == 37
  end
end
