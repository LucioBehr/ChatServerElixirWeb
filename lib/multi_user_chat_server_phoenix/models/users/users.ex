defmodule MultiUserChatServerPhoenix.Models.Users do
  alias MultiUserChatServerPhoenix.Models.Users.Repositories.Database

  def validate_user(user_id_list, func) do
    Database.validate_user(user_id_list, func)
  end

  def get_user(user_id) do
    Database.get_user(user_id)
  end

  def create_user(user_name) do
    Database.create_user(user_name)
  end

  def delete_user(user_id) do
    Database.delete_user(user_id)
  end

  def update_last_checked_at(user_id) do
    Database.update_last_checked_at(user_id)
  end

  def alter_user_name(user_id, user_name) do
    Database.alter_user_name(user_id, user_name)
  end
end
