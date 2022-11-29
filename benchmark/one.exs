# One
report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

Benchee.run(%{
  "one" => fn -> Aoc21.One.count(report) end
})

# Result
# Name           ips        average  deviation         median         99th %
# one         6.90 M      144.85 ns    ±84.22%         103 ns         254 ns
