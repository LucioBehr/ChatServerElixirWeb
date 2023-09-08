defmodule MultiUserChatServerPhoenix.Repo.Migrations.CreatePrivMessages do
  use Ecto.Migration

  def change do
    create table(:priv_messages) do
      add :sender_id, references(:users, on_delete: :nothing)
      add :receiver_id, references(:users, on_delete: :nothing)
      add :content, :string
    end
  end
end
