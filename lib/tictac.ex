defmodule Tictac do
  alias Tictac.{Square, State}

  def start(ui) do
    with {:ok, game} <- State.new(ui),
         player <- ui.(game, :get_player),
         {:ok, game} <- State.event(game, {:choose_p1, player}),
         do: handle(game),
         else: (error -> error)
  end

  def check_player(player) do
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _ -> {:error, :invalid_player}
    end
  end

  def get_row(board, row) do
    for {%{row: r, col: _}, v} <- board, row == r, do: v
  end

  def get_col(board, col) do
    for {%{row: _, col: c}, v} <- board, col == c, do: v
  end

  def get_diagonals(board) do
    [
      for({%{row: r, col: c}, v} <- board, r == c, do: v),
      for({%{row: r, col: c}, v} <- board, r + c == 4, do: v)
    ]
  end

  def handle(%{status: :playing} = game) do
    player = game.turn

    with {row, col} <- game.ui.(game, :request_move),
         {:ok, board} <- play_at(game.board, row, col, game.turn),
         {:ok, game} <- State.event(%{game | board: board}, {:play, game.turn}),
         won? <- win_check(board, player),
         {:ok, game} <- State.event(game, {:check_for_winner, won?}),
         over? <- game_over?(game),
         {:ok, game} <- State.event(game, {:game_over?, over?}),
         do: handle(game),
         else: (error -> error)
  end

  def handle(%{status: :game_over} = game) do
    game.ui.(game, nil)
  end

  def place_piece(board, place, player) do
    case board[place] do
      :empty -> {:ok, %{board | place => player}}
      :x -> {:error, :occupied}
      :o -> {:error, :occupied}
      _ -> {:error, :invalid_location}
    end
  end

  def play_at(board, row, col, player) do
    with {:ok, valid_player} <- check_player(player),
         {:ok, square} <- Square.new(row, col),
         {:ok, new_board} <- place_piece(board, square, valid_player),
         do: {:ok, new_board}
  end

  def win_check(board, player) do
    cols = Enum.map(1..3, &get_col(board, &1))
    rows = Enum.map(1..3, &get_row(board, &1))
    diagonals = get_diagonals(board)

    win? = Enum.any?(cols ++ rows ++ diagonals, &won_line(&1, player))

    if win?, do: player, else: false
  end

  def won_line(line, player), do: Enum.all?(line, &(player == &1))

  def game_over?(game) do
    board_full? = Enum.all?(game.board, fn {_, v} -> v != :empty end)

    if board_full? or game.winner do
      :game_over
    else
      :not_over
    end
  end
end
