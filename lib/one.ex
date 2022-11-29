defmodule Aoc21.One do
  @spec count([integer]) :: integer
  def count(report) do
    do_count(report)
  end

  def do_count(report, total \\ 0)

  def do_count([], total) do
    total
  end

  def do_count([_head | []], total) do
    total
  end

  def do_count([head | tail], total) do
    [second | _] = tail

    if second > head do
      do_count(tail, total + 1)
    else
      do_count(tail, total)
    end
  end
end
