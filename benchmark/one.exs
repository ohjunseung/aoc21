# One
report = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

Benchee.run(%{
  "one" => fn -> Aoc21.One.count(report) end
})
