defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :group_name, :string
      add :deleted, :boolean, default: false
      timestamps()
    end
  end
end
