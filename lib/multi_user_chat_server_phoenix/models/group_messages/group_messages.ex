defmodule MultiUserChatServerPhoenix.Models.GroupMessages do
  alias MultiUserChatServerPhoenix.Models.GroupMessages.Repositories.Database

  def get_group_messages(group_id) do
    Database.get_group_messages(group_id)
  end

  def get_sended_group_messages(user_id, group_id) do
    Database.get_sended_group_messages(user_id, group_id)
  end

  def get_pending_messages(user_id, last_checked) do
    Database.get_pending_messages(user_id, last_checked)
  end

  def insert_group_message(user_id, group_id, content) do
    Database.insert_group_message(user_id, group_id, content)
  end
end
