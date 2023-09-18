defmodule MultiUserChatServerPhoenix.Models.GroupMessages.Repositories.Database do
  alias MultiUserChatServerPhoenix.Models.GroupMessages.Schema.GroupMessage
  alias MultiUserChatServerPhoenix.Repo
  import Ecto.Query

  def get_group_messages(group_id) do
    Repo.all(from g in GroupMessage, where: g.group_id == ^group_id)
  end

  def get_sended_group_messages(user_id, group_id) do
    Repo.all(from m in GroupMessage, where: m.user_id == ^user_id and m.group_id == ^group_id)
  end

  def get_pending_messages(user_id, last_checked) do
    Repo.all(
      from m in GroupMessage, where: m.user_id != ^user_id and m.inserted_at > ^last_checked
    )
  end

  def insert_group_message(user_id, group_id, content) do
    Repo.insert(%GroupMessage{user_id: user_id, group_id: group_id, content: content})
  end
end
