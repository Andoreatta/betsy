defmodule BetsyWeb.BoardControllerTest do
  use BetsyWeb.ConnCase

  import Betsy.ImageboardFixtures

  @create_attrs %{
    description: "some description",
    title: "some title",
    board_uri: "some board_uri",
    rules: "some rules",
    enable_names: true,
    is_nsfw: true,
    is_locked: true,
    is_hidden: true,
    bump_limit: 42,
    total_posts: 42,
    moderators: ["option1", "option2"]
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    board_uri: "some updated board_uri",
    rules: "some updated rules",
    enable_names: false,
    is_nsfw: false,
    is_locked: false,
    is_hidden: false,
    bump_limit: 43,
    total_posts: 43,
    moderators: ["option1"]
  }
  @invalid_attrs %{
    description: nil,
    title: nil,
    board_uri: nil,
    rules: nil,
    enable_names: nil,
    is_nsfw: nil,
    is_locked: nil,
    is_hidden: nil,
    bump_limit: nil,
    total_posts: nil,
    moderators: nil
  }

  describe "index" do
    test "lists all boards", %{conn: conn} do
      conn = get(conn, ~p"/boards")
      assert html_response(conn, 200) =~ "Listing Boards"
    end
  end

  describe "new board" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/boards/new")
      assert html_response(conn, 200) =~ "New Board"
    end
  end

  describe "create board" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/boards", board: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/boards/#{id}"

      conn = get(conn, ~p"/boards/#{id}")
      assert html_response(conn, 200) =~ "Board #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/boards", board: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Board"
    end
  end

  describe "edit board" do
    setup [:create_board]

    test "renders form for editing chosen board", %{conn: conn, board: board} do
      conn = get(conn, ~p"/boards/#{board}/edit")
      assert html_response(conn, 200) =~ "Edit Board"
    end
  end

  describe "update board" do
    setup [:create_board]

    test "redirects when data is valid", %{conn: conn, board: board} do
      conn = put(conn, ~p"/boards/#{board}", board: @update_attrs)
      assert redirected_to(conn) == ~p"/boards/#{board}"

      conn = get(conn, ~p"/boards/#{board}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, board: board} do
      conn = put(conn, ~p"/boards/#{board}", board: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Board"
    end
  end

  describe "delete board" do
    setup [:create_board]

    test "deletes chosen board", %{conn: conn, board: board} do
      conn = delete(conn, ~p"/boards/#{board}")
      assert redirected_to(conn) == ~p"/boards"

      assert_error_sent 404, fn ->
        get(conn, ~p"/boards/#{board}")
      end
    end
  end

  defp create_board(_) do
    board = board_fixture()
    %{board: board}
  end
end
