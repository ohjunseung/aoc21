defmodule Aoc21.Five do
  @spec run([{{integer, integer}, {integer, integer}}]) :: integer
  def run(input) do
    input
    |> Enum.flat_map(&gen_coord(&1))
    |> Enum.reduce(%{}, fn k, acc -> Map.put(acc, k, Map.get(acc, k, 1) + 1) end)
    |> Enum.filter(fn {_, v} -> v >= 2 end)
    |> Enum.count()
  end

  @spec gen_coord({{integer, integer}, {integer, integer}}) :: [{integer, integer}]
  defp gen_coord({{ax, ay}, {bx, by}}) do
    cond do
      ax == bx && ay == by ->
        [{ax, ay}]

      ax == bx ->
        do_gen_coord(ax, ay, by)

      ay == by ->
        do_gen_coord(ay, ax, bx) |> Enum.map(fn {y, x} -> {x, y} end)

      true ->
        []
    end
  end

  defp do_gen_coord(_, _, _, acc \\ [])

  defp do_gen_coord(xy, from, from, acc) do
    acc ++ [{xy, from}]
  end

  defp do_gen_coord(xy, from, to, acc) do
    {from, to} = if to < from, do: {to, from}, else: {from, to}
    do_gen_coord(xy, from + 1, to, acc ++ [{xy, from}])
  end
end
