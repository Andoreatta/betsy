defmodule Betsy.ImageboardTest do
  use Betsy.DataCase

  alias Betsy.Imageboard

  describe "boards" do
    alias Betsy.Imageboard.Board

    import Betsy.ImageboardFixtures

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

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Imageboard.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Imageboard.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      valid_attrs = %{
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

      assert {:ok, %Board{} = board} = Imageboard.create_board(valid_attrs)
      assert board.description == "some description"
      assert board.title == "some title"
      assert board.board_uri == "some board_uri"
      assert board.rules == "some rules"
      assert board.enable_names == true
      assert board.is_nsfw == true
      assert board.is_locked == true
      assert board.is_hidden == true
      assert board.bump_limit == 42
      assert board.total_posts == 42
      assert board.moderators == ["option1", "option2"]
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Imageboard.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()

      update_attrs = %{
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

      assert {:ok, %Board{} = board} = Imageboard.update_board(board, update_attrs)
      assert board.description == "some updated description"
      assert board.title == "some updated title"
      assert board.board_uri == "some updated board_uri"
      assert board.rules == "some updated rules"
      assert board.enable_names == false
      assert board.is_nsfw == false
      assert board.is_locked == false
      assert board.is_hidden == false
      assert board.bump_limit == 43
      assert board.total_posts == 43
      assert board.moderators == ["option1"]
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Imageboard.update_board(board, @invalid_attrs)
      assert board == Imageboard.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Imageboard.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Imageboard.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Imageboard.change_board(board)
    end
  end

  describe "posts" do
    alias Betsy.Imageboard.Post

    import Betsy.ImageboardFixtures

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

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Imageboard.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Imageboard.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{
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

      assert {:ok, %Post{} = post} = Imageboard.create_post(valid_attrs)
      assert post.ipv4_address == "some ipv4_address"
      assert post.is_sticky == true
      assert post.ipv6_address == "some ipv6_address"
      assert post.body == "some body"
      assert post.post_uuid == "7488a646-e31f-11e4-aace-600308960662"
      assert post.reply_to_post_uuid == "7488a646-e31f-11e4-aace-600308960662"
      assert post.poster_name == "some poster_name"
      assert post.subject == "some subject"
      assert post.is_sage == true
      assert post.is_locked == true
      assert post.is_banned == true
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Imageboard.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
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

      assert {:ok, %Post{} = post} = Imageboard.update_post(post, update_attrs)
      assert post.ipv4_address == "some updated ipv4_address"
      assert post.is_sticky == false
      assert post.ipv6_address == "some updated ipv6_address"
      assert post.body == "some updated body"
      assert post.post_uuid == "7488a646-e31f-11e4-aace-600308960668"
      assert post.reply_to_post_uuid == "7488a646-e31f-11e4-aace-600308960668"
      assert post.poster_name == "some updated poster_name"
      assert post.subject == "some updated subject"
      assert post.is_sage == false
      assert post.is_locked == false
      assert post.is_banned == false
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Imageboard.update_post(post, @invalid_attrs)
      assert post == Imageboard.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Imageboard.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Imageboard.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Imageboard.change_post(post)
    end
  end
end
