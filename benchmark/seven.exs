input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

Benchee.run(%{
  "Enum" => fn -> Aoc21.Seven.run(input) end
})

# Name           ips        average  deviation         median         99th %
# Enum      246.23 K        4.06 μs   ±546.11%        3.08 μs       16.91 μs
# Must be other smarter solution. This is pure Enum functional though.
