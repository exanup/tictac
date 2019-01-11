defmodule Tictac.SquareTest do
  use ExUnit.Case

  alias Tictac.Square

  test "Create various valid and invalid squares" do
    assert Square.new(2, 3) == {:ok, %Square{row: 2, col: 3}}
    assert Square.new(1, 1) == {:ok, %Square{row: 1, col: 1}}
    assert Square.new(4, 3) == {:error, :invalid_square}
  end

  test "Get all squares in a tictac board" do
    required_squares =
      MapSet.new([
        %Square{row: 1, col: 1},
        %Square{row: 1, col: 2},
        %Square{row: 1, col: 3},
        %Square{row: 2, col: 1},
        %Square{row: 2, col: 2},
        %Square{row: 2, col: 3},
        %Square{row: 3, col: 1},
        %Square{row: 3, col: 2},
        %Square{row: 3, col: 3}
      ])

    assert Square.squares() == required_squares
  end

  test "Get a new board of tictac" do
    required_board = %{
      %Square{row: 1, col: 1} => :empty,
      %Square{row: 1, col: 2} => :empty,
      %Square{row: 1, col: 3} => :empty,
      %Square{row: 2, col: 1} => :empty,
      %Square{row: 2, col: 2} => :empty,
      %Square{row: 2, col: 3} => :empty,
      %Square{row: 3, col: 1} => :empty,
      %Square{row: 3, col: 2} => :empty,
      %Square{row: 3, col: 3} => :empty
    }

    assert Square.new_board() == required_board
  end
end
