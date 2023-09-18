defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreateUsersGroups do
  use Ecto.Migration

  def change do
    create table(:users_groups) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :group_id, references(:groups, on_delete: :delete_all)
      add :admin, :boolean

      timestamps()
    end
  end
end
