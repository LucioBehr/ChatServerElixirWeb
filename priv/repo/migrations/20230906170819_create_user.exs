defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :deleted, :boolean, default: false
      add :last_checked_at, :utc_datetime
      timestamps()
    end
  end
end
