defmodule MultiUserChatServerPhoenix.Models.PrivMessages.Repositories.Database do
  alias MultiUserChatServerPhoenix.Models.PrivMessages.Schema.PrivMessage
  alias MultiUserChatServerPhoenix.Repo
  import Ecto.Query

  def get_sended_messages(user_id) do
    Repo.all(from p in PrivMessage, where: p.sender_id == ^user_id)
  end

  def get_received_messages(user_id) do
    Repo.all(from p in PrivMessage, where: p.receiver_id == ^user_id)
  end

  def get_pending_messages(user_id, last_checked) do
    Repo.all(
      from p in PrivMessage, where: p.receiver_id == ^user_id and p.inserted_at >= ^last_checked
    )
  end

  def insert_priv_message(user_id, to_user_id, content) do
    Repo.insert(
      PrivMessage.changeset(%PrivMessage{}, %{
        sender_id: user_id,
        receiver_id: to_user_id,
        content: content
      })
    )
  end
end

# ~N[2023-09-14 17:08:47] checou
# ~N[2023-09-14 17:09:08] segunda chegagem
