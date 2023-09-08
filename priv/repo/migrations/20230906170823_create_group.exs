defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :group_name, :string
    end
  end
end
