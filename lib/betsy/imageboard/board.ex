defmodule Betsy.Imageboard.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :board_uri, :string, primary_key: true
    field :title, :string
    field :description, :string
    field :rules, :string
    field :owner_id, :id
    field :enable_names, :boolean, default: true
    field :is_nsfw, :boolean, default: false
    field :is_locked, :boolean, default: false
    field :is_hidden, :boolean, default: true
    field :bump_limit, :integer, default: 2048
    field :total_posts, :integer, default: 0
    field :moderators, {:array, :string}
    timestamps(type: :utc_datetime)

    has_many :posts, Betsy.Imageboard.Post, foreign_key: :board_uri
  end

  @doc false
  defp changeset(board, attrs) do
    board
    |> cast(attrs, [
      :board_uri,
      :title,
      :description,
      :rules,
      :owner_id,
      :enable_names,
      :is_nsfw,
      :is_locked,
      :is_hidden,
      :bump_limit,
      :total_posts,
      :moderators
    ])
    |> validate_required([:board_uri, :title, :owner_id])
    |> validate_length(:board_uri, min: 3, max: 32)
    |> validate_length(:title, min: 3, max: 32)
    |> validate_length(:description, max: 128)
    |> validate_length(:rules, max: 512)
  end
end
