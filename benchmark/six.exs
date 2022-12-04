initial = [3, 4, 3, 1, 2]

Benchee.run(%{
  "Enum" => fn -> Aoc21.Six.simulate(initial, 80) end,
})
# Name           ips        average  deviation         median         99th %
# Enum        102.16        9.79 ms    ±34.16%       12.04 ms       13.29 ms
# super simple answer and super slow
