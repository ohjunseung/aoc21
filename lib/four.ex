defmodule Aoc21.Four do
  defmodule Board do
    @moduledoc """
    This is a Bingo Board
    """
    @type t :: %__MODULE__{
            state: [integer],
            col_size: integer
          }
    defstruct state: [], col_size: 5

    @spec generate(integer) :: Board.t()
    def generate(size \\ 5)

    def generate(size) do
      %Board{
        state: state_generator(size * size),
        col_size: size
      }
    end

    defp state_generator(size, max_num \\ 27)

    defp state_generator(size, max_num) do
      0..(max_num - 1) |> Enum.shuffle() |> Enum.take(size)
    end

    @spec get(Board.t(), integer, integer, boolean) :: integer | {boolean, integer} | nil
    def get(board, row, col, with_marking \\ false)

    def get(board, row, col, with_marking) do
      if row >= ceil(length(board.state) / board.col_size) ||
           col >= board.col_size ||
           col < 0 || row < 0 do
        nil
      else
        index = col + row * board.col_size
        cell = board.state |> Enum.at(index)
        {marking, cell} = Board.Marking.read(cell)

        if with_marking, do: {marking, cell}, else: cell
      end
    end

    @spec update(Board.t(), integer, integer, boolean) :: Board.t()
    def update(board, row, col, marking) do
      if row >= ceil(length(board.state) / board.col_size) ||
           col >= board.col_size ||
           col < 0 || row < 0 do
        board
      end

      index = col + row * board.col_size

      %Board{
        board
        | state: List.update_at(board.state, index, &Board.Marking.mark(&1, marking))
      }
    end

    @spec check_win(Board.t()) :: boolean
    def check_win(board) do
      do_check_win(board)
    end

    @spec do_check_win(Board.t()) :: boolean
    defp do_check_win(board) do
      if do_check_win_row(board, div(length(board.state) - 1, board.col_size)) do
        true
      else
        do_check_win_col(board, board.col_size - 1)
      end
    end

    defp do_check_win_row(_, _, win \\ false)

    defp do_check_win_row(_, -1, win), do: win

    defp do_check_win_row(board, iteration, _win) do
      curr_row = Enum.slice(board.state, iteration * board.col_size, board.col_size)

      curr_row_count =
        Enum.reduce(curr_row, 0, fn x, acc ->
          {marked, _} = Board.Marking.read(x)

          if marked, do: acc + 1, else: acc
        end)

      if curr_row_count == 5 do
        do_check_win_row(board, -1, true)
      else
        do_check_win_row(board, iteration - 1, false)
      end
    end

    defp do_check_win_col(_, _, win \\ false)
    defp do_check_win_col(_, -1, win), do: win

    defp do_check_win_col(board, iteration, _) do
      curr_col_count =
        board.state
        |> Enum.with_index(iteration)
        |> Enum.filter(fn {_v, i} -> rem(i, board.col_size) == 0 end)
        |> Enum.reduce(0, fn {v, _i}, acc ->
          {marked, _} = Board.Marking.read(v)
          if marked, do: acc + 1, else: acc
        end)

      if curr_col_count == 5 do
        do_check_win_col(board, -1, true)
      else
        do_check_win_col(board, iteration - 1, false)
      end
    end

    @spec get_score(Board.t(), integer) :: integer
    def get_score(board, just_called) do
      just_called * do_get_score(board.state)
    end

    @spec do_get_score([integer], integer) :: integer | none
    defp do_get_score(_, sum \\ 0)

    defp do_get_score([], sum), do: sum

    defp do_get_score([head | tail], sum) do
      case Board.Marking.read(head) do
        {false, num} -> do_get_score(tail, sum + num)
        {true, _} -> do_get_score(tail, sum)
      end
    end

    @spec printf(Board.t()) :: [[integer]]
    def printf(board) do
      board.state
      |> Enum.map(&Board.Marking.read(&1))
      |> Enum.chunk_every(board.col_size)
    end
  end

  defmodule Board.Marking do
    import Bitwise

    @spec mark(integer, boolean) :: integer
    def mark(input, marking) do
      if marking do
        input ||| 0x80000000
      else
        input &&& 0x0FFFFFFF
      end
    end

    @spec read(integer) :: {boolean, integer}
    def read(input) do
      if (input &&& 0x80000000) == 0x80000000 do
        {true, input &&& 0x0FFFFFFF}
      else
        {false, input}
      end
    end
  end

  def bingo_draw(size \\ 27)

  def bingo_draw(size) do
    Enum.shuffle(0..(size - 1))
  end

  def game() do
    IO.puts("Four: Game start")
    pool = bingo_draw()
    IO.inspect(pool, label: "bingo draw")
    board_a = Board.generate()
    board_b = Board.generate()
    board_c = Board.generate()
    IO.inspect(Board.printf(board_a), label: "board a")
    IO.inspect(Board.printf(board_b), label: "board b")
    IO.inspect(Board.printf(board_c), label: "board c")

    pool
    |> Enum.each(fn draw ->
      case Enum.find_index(board_a.state, &(&1 == draw)) do
        i when is_integer(i) ->
          %Board{
            board_a
            | state: List.update_at(board_a.state, i, &Board.Marking.mark(&1, true))
          }

        _ ->
          board_a
      end

      if Board.check_win(board_a), do: Board.get_score(board_a, draw) |> IO.puts()
    end)
  end

  @spec do_run_board(Board.t(), [integer]) :: {Board.t(), integer, integer}
  defp do_run_board(board, pool) do
  end
end
