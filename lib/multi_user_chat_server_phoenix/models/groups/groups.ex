defmodule MultiUserChatServerPhoenix.Models.Groups do
  alias MultiUserChatServerPhoenix.Models.Groups.Repositories.Database

  def validate_group(group_id_list, func) do
    Database.validate_group(group_id_list, func)
  end

  def get_group(group_id) do
    Database.get_group(group_id)
  end

  def create_group(group_name) do
    Database.create_group(group_name)
  end

  def delete_group(group_id) do
    Database.delete_group(group_id)
  end
end
