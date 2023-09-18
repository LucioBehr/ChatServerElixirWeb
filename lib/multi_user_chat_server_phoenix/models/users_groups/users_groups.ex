defmodule MultiUserChatServerPhoenix.Models.UsersGroups do
  alias MultiUserChatServerPhoenix.Models.UsersGroups.Repositories.Database

  def get_users_group(user_id, group_id) do
    Database.get_users_group(user_id, group_id)
  end

  def insert_user_group(user_id, group_id, admin \\ false) do
    case get_users_group(user_id, group_id) do
      nil -> Database.insert_user_group(user_id, group_id, admin)
      _ -> {:error, :user_already_in_group}
    end
  end
end
