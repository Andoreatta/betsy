defmodule Betsy.Repo.Migrations.CreateBoardsAndPosts do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto;"

    create table(:boards) do
      add :board_uri, :string, primary_key: true, null: false, size: 32
      add :title, :string, null: false, size: 64
      add :description, :text
      add :rules, :text
      add :owner_id, references(:users, on_delete: :delete_all), null: false
      add :enable_names, :boolean, default: true, null: false
      add :is_nsfw, :boolean, default: false, null: false
      add :is_locked, :boolean, default: false, null: false
      add :is_indexed, :boolean, default: true, null: false
      add :bump_limit, :integer, default: 2048, null: false
      add :total_posts, :integer, default: 0, null: false
      add :moderators, {:array, :string} # (username) redundant, but useful for quick lookups
      timestamps(type: :utc_datetime)
    end
    create unique_index(:boards, :board_uri)

    create table(:posts) do
      add :board_uri, references(:boards, column: :board_uri, type: :string, on_delete: :delete_all)
      add :post_id, :bigserial, primary_key: false,
          generated_as: [partition_by: :board_uri, start_with: 1, increment_by: 1]
      add :reply_to_post_id, :bigserial, references(:posts, column: :post_id, type: :bigserial, on_delete: :nilify_all)
      add :ipv4_address, :inet
      add :ipv6_address, :inet
      add :poster_name, :string, size: 32
      add :subject, :string, size: 64
      add :body, :text, null: false
      add :is_sage, :boolean, default: false, null: false
      add :is_sticky, :boolean, default: false, null: false
      add :is_locked, :boolean, default: false, null: false
      add :is_banned, :boolean, default: false, null: false
      timestamps(type: :utc_datetime)
    end

    # Definir a chave primária composta:
    execute "ALTER TABLE posts ADD PRIMARY KEY (board_uri, post_id);"

    create index(:posts, [:post_id, :reply_to_post_id])
  end
end
