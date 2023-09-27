defmodule MultiUserChatServerPhoenixWeb.ChatServerPrivate do
  alias MultiUserChatServerPhoenix.Models.{Users, PrivMessages, GroupMessages}

  def validate_user(user_id_list, func) do
    Users.validate_user(user_id_list, func)
  end

  def get_user(user_id) do
    Users.get_user(user_id)
  end

  def create_user(user_name) do
    Users.create_user(user_name)
  end

  def delete_user(user_id) do
    Users.delete_user(user_id)
  end

  def get_sended_messages(user_id) do
    Users.validate_user([user_id], fn ->
      {:ok, PrivMessages.get_sended_messages(user_id)}
    end)
  end

  def get_received_messages(user_id) do
    Users.validate_user([user_id], fn ->
      {:ok, PrivMessages.get_received_message(user_id)}
    end)
  end

  def get_pending_messages(user_id) do
    Users.validate_user([user_id], fn ->
      last_checked = Map.get(get_user(user_id), :last_checked_at)
      Users.update_last_checked_at(user_id)

      {:ok,
       %{
         private_pending_messages: PrivMessages.get_pending_messages(user_id, last_checked),
         group_pending_messages: GroupMessages.get_pending_messages(user_id, last_checked)
       }}
    end)
  end

  def send_priv_message(sender, receiver, content) do
    Users.validate_user([sender, receiver], fn ->
      PrivMessages.insert_priv_message(sender, receiver, content)
    end)
  end

  # ~U[2023-09-14 16:59:19Z] criacao de novo usuario
  # ~N[2023-09-14 16:59:53] envio da msg privada
  # ~U[2023-09-14 17:00:24Z] novo last_checked

  def alter_name(user_id, new_user_name) do
    Users.validate_user([user_id], fn ->
      Users.alter_user_name(user_id, new_user_name)
    end)
  end
end
