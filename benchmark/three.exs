#Three
report = [
  0b00100,
  0b11110,
  0b10110,
  0b10111,
  0b10101,
  0b01111,
  0b00111,
  0b11100,
  0b10000,
  0b11001,
  0b00010,
  0b01010,
]

Benchee.run(%{
  "three" => fn -> Aoc21.Three.count_power(report) end
})
