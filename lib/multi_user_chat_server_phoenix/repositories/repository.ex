# defmodule MultiUserChatServerPhoenixWeb.Queries do
#  alias MultiUserChatServerPhoenix.Repo
#
#  alias MultiUserChatServerPhoenix.Models.{
#    Users,
#    PrivMessages,
#    GroupMessages,
#    Groups,
#    UsersGroups
#  }
#
#  import Ecto.Query
#
#  ######## char_server_group ########
#  def validate_data(user_id, group_id) do
#    case {get_user(user_id), get_group(group_id), get_group_users(user_id, group_id)} do
#      {nil, _, _} ->
#        {:error, :missing_user}
#      {_, nil, _} ->
#        {:error, :missing_group}
#
#      {_, _, nil} ->
#        {:error, :missing_user_group}
#
#      _ ->
#        {:ok, :user_in_group}
#    end
#  end
# ######## user ######## OK
#  def get_user(user_id) do
#    Repo.get(Users, user_id)
#  end
# ######## group ######## OK
#  def get_group(group_id) do
#    Repo.get(Groups, group_id)
#  end
# ######## users_group ######## OK
#  def get_group_users(user_id, group_id) do
#    Repo.get_by(UsersGroups, %{user_id: user_id, group_id: group_id})
#  end
# ######## group_messages ########
#  def get_group_messages(group_id) do
#    Repo.all(from m in GroupMessages, where: m.group_id == ^group_id)
#  end
#
#  ######## priv_messages e group_messages ########
#  def get_messages(user_id) do
#    # pegar as priv e group messages do user
#  end
#
#   ######## user ########
#  def create_user(user_name) do
#  Repo.insert(Users.changeset(%User{}, %{user_name: user_name}))
#  end
#   ######## user ########
#  def delete_user(user_id) do
#    Repo.delete(Repo.get(Users, user_id))
#  end
#   ######## priv_messages ########
#  def insert_priv_message(user_id, to_user_id, content) do
#    Repo.insert(%PrivMessages{sender: user_id, receiver: to_user_id, content: content})
#  end
#
#  ######## group_messages ########
#  def get_group_messages(user_id, group_id) do
#    Repo.all(from m in GroupMessages, where: m.group_id == ^group_id and m.user_id == ^user_id)
#  end
#
#  ######## group e users_group ########
#  def create_group(user_id, group_name) do
#    {:ok, group} = Repo.insert(%Groups{group_name: group_name})
#    Repo.insert(%UsersGroups{user_id: user_id, group_id: group.id, admin: true})
#  end
#     ######## users_group ########
#  def insert_user_group(user_id, group_id) do
#    Repo.insert(%UsersGroups{user_id: user_id, group_id: group_id})
#  end
#     ######## group_message ########
#  def insert_group_message(user_id, group_id, content) do
#    Repo.insert(%GroupMessages{user_id: user_id, group_id: group_id, content: content})
#  end
# end
#
