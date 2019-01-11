defmodule TictacTest do
  use ExUnit.Case

  alias Tictac.Square

  test "Check if player is valid" do
    assert Tictac.check_player(:x) == {:ok, :x}
    assert Tictac.check_player(:o) == {:ok, :o}
    assert Tictac.check_player(:X) == {:error, :invalid_player}
    assert Tictac.check_player(:a) == {:error, :invalid_player}
    assert Tictac.check_player(Xyz) == {:error, :invalid_player}
  end

  test "Place piece at various squares in a board" do
    player1 = :x
    player2 = :o

    # get a clean board at first
    game_board = Square.new_board()

    # place `player1` at `square`
    {:ok, square} = Square.new(3, 2)
    new_board = %{game_board | %Square{row: 3, col: 2} => :x}
    assert Tictac.place_piece(game_board, square, player1) == {:ok, new_board}

    # update game board
    game_board = new_board

    # place `player2` at another `square`
    {:ok, square} = Square.new(2, 1)
    new_board = %{game_board | %Square{row: 2, col: 1} => :o}
    assert Tictac.place_piece(game_board, square, player2) == {:ok, new_board}

    # TODO: place player to pre-occupied square
    # TODO: place player to invalid square
  end

  # TODO: write tests for Tictac.play_at/4
end
