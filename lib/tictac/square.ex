defmodule Tictac.Square do
  alias Tictac.Square

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_size 1..3

  def new(row, col) when row in @board_size and col in @board_size do
    {:ok, %Square{row: row, col: col}}
  end

  def new(_row, _col), do: {:error, :invalid_square}

  def new_board do
    for s <- squares(), into: %{} do
      {s, :empty}
    end
  end

  def squares do
    for r <- @board_size, c <- @board_size, into: MapSet.new() do
      %Square{row: r, col: c}
    end
  end
end
