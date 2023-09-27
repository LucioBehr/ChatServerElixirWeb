defmodule MultiUserChatServerPhoenix do
  alias MultiUserChatServerPhoenixWeb.ChatServerPrivate, as: PrivLogic
  alias MultiUserChatServerPhoenixWeb.ChatServerGroup, as: GroupLogic

  def create_user(%{"user_name" => user_name}), do: PrivLogic.create_user(user_name)

  def get_user(%{"user_id" => user_id}), do: PrivLogic.get_user(user_id)

  def alter_name(%{"user_id" => user_id, "new_user_name" => new_user_name}),
    do: PrivLogic.alter_name(user_id, new_user_name)

  def delete_user(%{"user_id" => user_id}), do: PrivLogic.delete_user(user_id)

  def send_priv_message(%{
        "sender" => sender,
        "receiver" => receiver,
        "content" => content
      }),
      do: PrivLogic.send_priv_message(sender, receiver, content)

  def get_sended_private_messages(%{"user_id" => user_id}),
    do: PrivLogic.get_sended_messages(user_id)

  def get_received_private_messages(%{"user_id" => user_id}),
    do: PrivLogic.get_received_messages(user_id)

  def get_pending_messages(%{"user_id" => user_id}),
    do: PrivLogic.get_pending_messages(user_id)

  ### Group Logic ###

  def create_group(%{"user_id" => user_id, "group_name" => group_name}),
    do: GroupLogic.create_group(user_id, group_name)

  def enter_group(%{"user_id" => user_id, "group_id" => group_id}),
    do: GroupLogic.enter_group(user_id, group_id)

  def send_group_message(%{"user_id" => user_id, "group_id" => group_id, "content" => content}),
    do: GroupLogic.send_group_message(user_id, group_id, content)

  def get_received_group_messages(%{"user_id" => user_id, "group_id" => group_id}),
    do: GroupLogic.get_received_group_messages(user_id, group_id)

  def get_sended_group_messages(%{"user_id" => user_id, "group_id" => group_id}),
    do: GroupLogic.get_sended_group_messages(user_id, group_id)
end
