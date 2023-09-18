defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreateGroupMessages do
  use Ecto.Migration

  def change do
    create table(:group_messages) do
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :delete_all)
      add :content, :string

      timestamps()
    end
  end
end
