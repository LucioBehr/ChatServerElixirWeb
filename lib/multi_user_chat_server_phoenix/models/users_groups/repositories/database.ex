defmodule MultiUserChatServerPhoenix.Models.UsersGroups.Repositories.Database do
  alias MultiUserChatServerPhoenix.Models.UsersGroups.Schema.UserGroup
  alias MultiUserChatServerPhoenix.Repo

  def get_users_group(user_id, group_id) do
    Repo.get_by(UserGroup, %{user_id: user_id, group_id: group_id})
  end

  def insert_user_group(user_id, group_id, admin) do
    Repo.insert(%UserGroup{user_id: user_id, group_id: group_id, admin: admin})
  end
end
