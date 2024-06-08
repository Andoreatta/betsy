defmodule Betsy.Repo.Migrations.CreateBoardsAndPosts do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto;"

    create table(:boards, primary_key: false) do
      add :board_uri, :string, primary_key: true, null: false, size: 32
      add :title, :string, null: false, size: 64
      add :description, :string, size: 256
      add :rules, :string, size: 2048
      add :owner_id, references(:users, on_delete: :delete_all), null: false
      add :enable_names, :boolean, default: true, null: false
      add :is_nsfw, :boolean, default: false, null: false
      add :is_locked, :boolean, default: false, null: false
      add :is_hidden, :boolean, default: true, null: false
      add :bump_limit, :integer, default: 2048, null: false
      add :total_posts, :integer, default: 0, null: false
      # moderators is redundant, but useful for quick lookups
      add :moderators, {:array, :string}
      timestamps(type: :utc_datetime)
    end

    create unique_index(:boards, :board_uri)

    create table(:posts, primary_key: false) do
      add :board_uri,
          references(:boards, column: :board_uri, type: :string, on_delete: :delete_all)

      add :post_uuid, :uuid,
        primary_key: true,
        null: false,
        default: fragment("gen_random_uuid()")

      add :reply_to_post_uuid, :uuid
      add :ipv4_address, :inet
      add :ipv6_address, :inet
      add :poster_name, :string, size: 32
      add :subject, :string, size: 64
      add :body, :string, size: 16384, null: false
      add :is_sage, :boolean, default: false, null: false
      add :is_sticky, :boolean, default: false, null: false
      add :is_locked, :boolean, default: false, null: false
      add :is_banned, :boolean, default: false, null: false
      timestamps(type: :utc_datetime)
    end

    create unique_index(:posts, [:board_uri, :post_uuid])
    create index(:posts, [:post_uuid, :reply_to_post_uuid])
  end
end
