defmodule Aoc21.Six do
  @spec simulate([integer], integer) :: integer
  def simulate(initial, days) do
    1..days
    |> Enum.reduce(initial, fn _, acc ->
      {head, tail} =
        Enum.map_reduce(acc, [], fn x, acc2 ->
          if x == 0 do
            {6, acc2 ++ [8]}
          else
            {x - 1, acc2}
          end
        end)

      head ++ tail
    end)
    |> Enum.count()
  end
end
