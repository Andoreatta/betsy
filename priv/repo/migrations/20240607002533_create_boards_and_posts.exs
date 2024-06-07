defmodule Betsy.Repo.Migrations.CreateBoardsAndPosts do
  use Ecto.Migration

  def change do
    create table(:boards, primary_key: false) do
      add :board_uri, :string, null: false
      add :title, :string, null: false
      add :description, :text
      add :rules, :text
      add :owner_id, references(:accounts, on_delete: :delete_all), null: false
      add :enable_names, :boolean, default: true
      add :is_nsfw, :boolean, default: false
      add :is_locked, :boolean, default: false
      add :is_indexed, :boolean, default: true
      add :bump_limit, :integer, default: 1000
      add :moderators, {:array, :string}
      timestamps()
    end

    create unique_index(:boards, [:board_uri])

    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto;"

    create table(:posts) do
      add :board_uri, :string, null: false
      add :post_uuid, :uuid, null: false, default: fragment("gen_random_uuid()")
      add :reply_to_post_uuid, :uuid
      add :ipv4_address, :inet
      add :ipv6_address, :inet
      add :poster_name, :string, size: 32
      add :subject, :string, size: 64
      add :body, :text, null: false
      add :is_sage, :boolean, default: false
      add :is_sticky, :boolean, default: false
      add :is_locked, :boolean, default: false
      add :is_banned, :boolean, default: false
      timestamps()
    end

    create index(:posts, [:board_uri, :post_uuid], unique: true)

    create constraint(:posts, :board_uri_fkey,
             foreign_key: :board_uri,
             references: :boards,
             column: :board_uri,
             on_delete: :delete_all
           )
  end
end
