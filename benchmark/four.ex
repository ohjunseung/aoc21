defmodule Bench do
  def state_generator(iteration, acc \\ [], max_num \\ 27)

  def state_generator(0, acc, _) do
    acc
  end

  def state_generator(iteration, acc, max_num) do
    num = :rand.uniform(max_num) - 1

    if num in acc do
      state_generator(iteration, acc)
    else
      state_generator(iteration - 1, acc ++ [num])
    end
  end

  def state_generator2(size, max_num \\ 27)

  def state_generator2(size, max_num) do
    0..(max_num - 1) |> Enum.shuffle() |> Enum.take(size)
  end
end

Benchee.run(%{
  "Recursion" => fn -> Bench.state_generator(25) end,
  "Enum" => fn -> Bench.state_generator2(25) end
})

# Result
# Name                ips        average  deviation         median         99th %
# Enum           203.55 K        4.91 μs   ±470.33%        3.29 μs        9.70 μs
# Recursion       60.27 K       16.59 μs    ±40.61%       16.10 μs       26.72 μs
#
# Comparison:
# Enum           203.55 K
# Recursion       60.27 K - 3.38x slower +11.68 μs
# Enum is much more faster. Pretty logical because of `num in acc` waste too much time.
