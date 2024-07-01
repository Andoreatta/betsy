defmodule BetsyWeb.BoardController do
  use BetsyWeb, :controller

  alias Betsy.Imageboard
  alias Betsy.Imageboard.Board

  def index(conn, _params) do
    boards = Imageboard.list_boards()
    render(conn, :index, boards: boards)
  end

  def new(conn, _params) do
    changeset = Imageboard.change_board(%Board{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"board" => board_params}) do
    case Imageboard.create_board(board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: ~p"/boards/#{board}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Imageboard.get_board!(id)
    render(conn, :show, board: board)
  end

  def edit(conn, %{"id" => id}) do
    board = Imageboard.get_board!(id)
    changeset = Imageboard.change_board(board)
    render(conn, :edit, board: board, changeset: changeset)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Imageboard.get_board!(id)

    case Imageboard.update_board(board, board_params) do
      {:ok, board} ->
        conn
        |> put_flash(:info, "Board updated successfully.")
        |> redirect(to: ~p"/boards/#{board}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, board: board, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Imageboard.get_board!(id)
    {:ok, _board} = Imageboard.delete_board(board)

    conn
    |> put_flash(:info, "Board deleted successfully.")
    |> redirect(to: ~p"/boards")
  end
end
