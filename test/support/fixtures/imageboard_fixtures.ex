defmodule Betsy.ImageboardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Betsy.Imageboard` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        board_uri: "some board_uri",
        bump_limit: 42,
        description: "some description",
        enable_names: true,
        is_hidden: true,
        is_locked: true,
        is_nsfw: true,
        moderators: ["option1", "option2"],
        rules: "some rules",
        title: "some title",
        total_posts: 42
      })
      |> Betsy.Imageboard.create_board()

    board
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        ipv4_address: "some ipv4_address",
        ipv6_address: "some ipv6_address",
        is_banned: true,
        is_locked: true,
        is_sage: true,
        is_sticky: true,
        post_uuid: "7488a646-e31f-11e4-aace-600308960662",
        poster_name: "some poster_name",
        reply_to_post_uuid: "7488a646-e31f-11e4-aace-600308960662",
        subject: "some subject"
      })
      |> Betsy.Imageboard.create_post()

    post
  end
end
