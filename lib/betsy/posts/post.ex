defmodule Betsy.Post do
  @moduledoc """
  This module represents a Post in the Betsy Imageboard.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :post_uuid, Ecto.UUID, primary_key: true
    field :reply_to_post_uuid, Ecto.UUID
    field :ipv4_address, :string
    field :ipv6_address, :string
    field :poster_name, :string
    field :subject, :string
    field :body, :string
    field :is_sage, :boolean, default: false
    field :is_sticky, :boolean, default: false
    field :is_locked, :boolean, default: false
    field :is_banned, :boolean, default: false
    timestamps(type: :utc_datetime)

    belongs_to :board, Betsy.Board, foreign_key: :board_uri, type: :string
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [
      :board_uri,
      :post_uuid,
      :reply_to_post_uuid,
      :ipv4_address,
      :ipv6_address,
      :poster_name,
      :subject,
      :body,
      :is_sage,
      :is_sticky,
      :is_locked,
      :is_banned
    ])
    |> validate_required([:board_uri, :body])
    |> foreign_key_constraint(:board_uri)
  end
end
