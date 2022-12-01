defmodule Aoc21Test.Four do
  use ExUnit.Case

  alias Aoc21.Four.Board, as: Board

  test "pool" do
    pool = Aoc21.Four.bingo_draw()
    assert length(pool) == 27
  end

  test "board" do
    board = Board.generate()
    assert length(board.state) == 25
  end

  test "board_get" do
    board = %Board{
      state: [1, 2, 3, 4, 5, 6, 7, 8],
      col_size: 2
    }

    assert board |> Board.get(0, 0) == 1
    assert board |> Board.get(1, 0) == 3
    assert board |> Board.get(3, 1) == 8
    assert board |> Board.get(4, 0) == nil
    assert board |> Board.get(2, 2) == nil
  end

  test "board_marking" do
    import Board.Marking

    board = %Board{
      state: [1, 2, 3, 4, 5, 6, 7, 8, mark(9, true)],
      col_size: 1
    }

    assert board |> Board.get(0, 0) == 1
    assert board |> Board.get(1, 0) == 2
    assert board |> Board.get(3, 0) == 4
    assert board |> Board.get(3, 0, true) == {false, 4}
    assert board |> Board.get(8, 0) == 9
    assert board |> Board.get(8, 0, true) == {true, 9}
    assert board |> Board.get(100, 0) == nil
    assert board |> Board.get(0, 1) == nil
  end

  test "board_update" do
    board = %Board{
      state: [1, 2, 3, 4, 5, 6, 7, 8],
      col_size: 2
    }

    board = Board.update(board, 1, 0, true)
    assert board |> Board.get(1, 0, true) == {true, 3}
  end

  test "board_score" do
    import Board.Marking

    board = %Board{
      state: [1, 1, 1, 1, 1, mark(9, true)],
      col_size: 1
    }

    assert Board.get_score(board, 2) == 10
  end

  test "board_win" do
    import Board.Marking

    board = %Board{
      state: [
        mark(14, true),
        mark(21, true),
        mark(17, true),
        mark(24, true),
        mark(4, true),
        10,
        16,
        15,
        mark(9, true),
        19,
        18,
        8,
        mark(23, true),
        26,
        20,
        22,
        mark(11, true),
        13,
        6,
        mark(5, true),
        mark(2, true),
        mark(0, true),
        12,
        3,
        mark(7, true)
      ],
      col_size: 5
    }

    board_2 = %Board{
      state: [
        mark(14, true),
        mark(21, true),
        17,
        mark(24, true),
        mark(4, true),
        10,
        16,
        15,
        mark(9, true),
        19,
        18,
        8,
        mark(23, true),
        26,
        20,
        22,
        mark(11, true),
        13,
        6,
        mark(5, true),
        mark(2, true),
        mark(0, true),
        12,
        3,
        mark(7, true)
      ],
      col_size: 5
    }

    board_3 = %Board{
      state: [
        mark(14, true),
        mark(21, true),
        17,
        mark(24, true),
        4,
        10,
        mark(16, true),
        15,
        mark(9, true),
        19,
        18,
        mark(8, true),
        mark(23, true),
        26,
        20,
        22,
        mark(11, true),
        13,
        6,
        mark(5, true),
        mark(2, true),
        mark(0, true),
        12,
        3,
        mark(7, true)
      ],
      col_size: 5
    }

    assert Board.check_win(board) == true
    assert Board.check_win(board_2) == false
    assert Board.check_win(board_3) == true
  end

  test "game" do
    Aoc21.Four.game()
  end
end
