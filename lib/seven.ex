defmodule Aoc21.Seven do
  @spec run([integer]) :: integer
  def run(input) do
    max = Enum.max(input)

    0..max
    |> Enum.map(fn i ->
      input
      |> Enum.map(fn x ->
        abs(x - i)
      end)
      |> Enum.sum()
    end)
    |> Enum.min()
  end
end
