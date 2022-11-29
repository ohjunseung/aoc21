defmodule Aoc21Test do
end

defmodule Aoc21Test.One do
  use ExUnit.Case

  test "one" do
    report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert Aoc21.One.count(report) == 7
  end
end
