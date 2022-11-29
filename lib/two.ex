defmodule Aoc21.Two do
  defmodule Ship do
    @type t :: %__MODULE__{
            position: integer,
            depth: integer
          }
    defstruct position: 0, depth: 0
  end

  defprotocol Move do
    @spec forward(Ship.t(), integer) :: Ship.t()
    def forward(ship, distance \\ 0)
    @spec up(Ship.t(), integer) :: Ship.t()
    def up(ship, units \\ 0)
    @spec down(Ship.t(), integer) :: Ship.t()
    def down(ship, units \\ 0)
  end

  defimpl Move, for: Ship do
    def forward(ship, distance) do
      %Ship{ship | position: ship.position + distance}
    end

    def up(ship, units) do
      %Ship{ship | depth: ship.depth - units}
    end

    def down(ship, units) do
      %Ship{ship | depth: ship.depth + units}
    end
  end
end
