defmodule Aoc21.Three do
  import Bitwise

  @spec reduce([integer]) :: %{integer => integer}
  def reduce(report) do
    do_reduce(report)
  end

  def do_reduce(_, result \\ %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0})

  def do_reduce([head | tail], result) do
    result = if (head &&& 0b10000) == 0b10000, do: %{result | 0 => result[0] + 1}, else: result
    result = if (head &&& 0b01000) == 0b01000, do: %{result | 1 => result[1] + 1}, else: result
    result = if (head &&& 0b00100) == 0b00100, do: %{result | 2 => result[2] + 1}, else: result
    result = if (head &&& 0b00010) == 0b00010, do: %{result | 3 => result[3] + 1}, else: result
    result = if (head &&& 0b00001) == 0b00001, do: %{result | 4 => result[4] + 1}, else: result

    do_reduce(tail, result)
  end

  def do_reduce([], result), do: result

  @spec count_gamma(%{integer => integer}, integer) :: integer
  def count_gamma(reduced, len) do
    result = 0b00000
    half = div(len, 2)

    result = if reduced[0] > half, do: result ||| 0b10000, else: result
    result = if reduced[1] > half, do: result ||| 0b01000, else: result
    result = if reduced[2] > half, do: result ||| 0b00100, else: result
    result = if reduced[3] > half, do: result ||| 0b00010, else: result
    result = if reduced[4] > half, do: result ||| 0b00001, else: result

    result
  end

  @spec count_epsilon(%{integer => integer}, integer) :: integer
  def count_epsilon(reduced, len) do
    result = 0b00000
    half = div(len, 2)

    result = if reduced[0] < half, do: result ||| 0b10000, else: result
    result = if reduced[1] < half, do: result ||| 0b01000, else: result
    result = if reduced[2] < half, do: result ||| 0b00100, else: result
    result = if reduced[3] < half, do: result ||| 0b00010, else: result
    result = if reduced[4] < half, do: result ||| 0b00001, else: result

    result
  end

  @spec count_power([integer]) :: integer
  def count_power(report) do
    len = length(report)
    reduced = reduce(report)
    count_gamma(reduced, len) * count_epsilon(reduced, len)
  end
end
