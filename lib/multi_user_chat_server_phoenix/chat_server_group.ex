defmodule MultiUserChatServerPhoenixWeb.ChatServerGroup do
  alias MultiUserChatServerPhoenix.Models.{Users, Groups, GroupMessages, UsersGroups}

  def validate_user_in_group(user_id, group_id) do
    Users.validate_user([user_id], fn ->
      Groups.validate_group([group_id], fn ->
        case UsersGroups.get_users_group(user_id, group_id) do
          nil -> {:error, :missing_user_group}
          _ -> {:ok, :user_in_group}
        end
      end)
    end)
  end

  def get_sended_group_messages(user_id, group_id) do
    case validate_user_in_group(user_id, group_id) do
      {:ok, :user_in_group} -> {:ok, GroupMessages.get_sended_group_messages(user_id, group_id)}
      error -> error
    end
  end

  def get_received_group_messages(user_id, group_id) do
    case validate_user_in_group(user_id, group_id) do
      {:ok, :user_in_group} -> {:ok, GroupMessages.get_group_messages(group_id)}
      error -> error
    end
  end

  def create_group(user_id, group_name) do
    Users.validate_user([user_id], fn ->
      {:ok, group} = Groups.create_group(group_name)
      UsersGroups.insert_user_group(user_id, group.id, true)
    end)
  end

  def send_group_message(user_id, group_id, content) do
    case validate_user_in_group(user_id, group_id) do
      {:ok, :user_in_group} -> GroupMessages.insert_group_message(user_id, group_id, content)
    end
  end

  def enter_group(user_id, group_id) do
    case validate_user_in_group(user_id, group_id) do
      {:ok, :user_in_group} -> {:error, "user #{user_id} is already in group #{group_id}"}
      {:error, :missing_user_group} -> UsersGroups.insert_user_group(user_id, group_id)
      error -> error
    end
  end
end
