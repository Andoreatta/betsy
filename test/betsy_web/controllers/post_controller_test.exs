defmodule BetsyWeb.PostControllerTest do
  use BetsyWeb.ConnCase

  import Betsy.ImageboardFixtures

  @create_attrs %{
    ipv4_address: "some ipv4_address",
    is_sticky: true,
    ipv6_address: "some ipv6_address",
    body: "some body",
    post_uuid: "7488a646-e31f-11e4-aace-600308960662",
    reply_to_post_uuid: "7488a646-e31f-11e4-aace-600308960662",
    poster_name: "some poster_name",
    subject: "some subject",
    is_sage: true,
    is_locked: true,
    is_banned: true
  }
  @update_attrs %{
    ipv4_address: "some updated ipv4_address",
    is_sticky: false,
    ipv6_address: "some updated ipv6_address",
    body: "some updated body",
    post_uuid: "7488a646-e31f-11e4-aace-600308960668",
    reply_to_post_uuid: "7488a646-e31f-11e4-aace-600308960668",
    poster_name: "some updated poster_name",
    subject: "some updated subject",
    is_sage: false,
    is_locked: false,
    is_banned: false
  }
  @invalid_attrs %{
    ipv4_address: nil,
    is_sticky: nil,
    ipv6_address: nil,
    body: nil,
    post_uuid: nil,
    reply_to_post_uuid: nil,
    poster_name: nil,
    subject: nil,
    is_sage: nil,
    is_locked: nil,
    is_banned: nil
  }

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/posts")
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/posts/new")
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/posts", post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert html_response(conn, 200) =~ "Post #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/posts", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    setup [:create_post]

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get(conn, ~p"/posts/#{post}/edit")
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "update post" do
    setup [:create_post]

    test "redirects when data is valid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/posts/#{post}", post: @update_attrs)
      assert redirected_to(conn) == ~p"/posts/#{post}"

      conn = get(conn, ~p"/posts/#{post}")
      assert html_response(conn, 200) =~ "some updated ipv4_address"
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, ~p"/posts/#{post}", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, ~p"/posts/#{post}")
      assert redirected_to(conn) == ~p"/posts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/posts/#{post}")
      end
    end
  end

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end
end
