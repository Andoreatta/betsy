defmodule Betsy.Repo.Migrations.AddUsernamesToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :citext, null: false
    end

    create unique_index(:users, :username)
  end
end
