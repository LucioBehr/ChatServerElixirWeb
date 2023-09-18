defmodule MultiUserChatServerPhoenix.Models.PrivMessages do
  alias MultiUserChatServerPhoenix.Models.PrivMessages.Repositories.Database

  def get_sended_messages(user_id) do
    Database.get_sended_messages(user_id)
  end

  def get_received_message(user_id) do
    Database.get_received_messages(user_id)
  end

  def get_pending_messages(user_id, last_checked) do
    Database.get_pending_messages(user_id, last_checked)
  end

  def insert_priv_message(sender, receiver, content) do
    Database.insert_priv_message(sender, receiver, content)
  end
end
