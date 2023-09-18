defmodule MultiUserChatServerPhoenix.Models.Groups.Repositories.Database do
  alias MultiUserChatServerPhoenix.Models.Groups.Schema.Group
  alias MultiUserChatServerPhoenix.Repo

  def validate_group([head], func) do
    case get_group(head) do
      nil -> {:error, :missing_group}
      _ -> func.()
    end
  end

  def validate_group([head | tail], func) do
    case get_group(head) do
      nil -> {:error, :missing_group}
      _ -> validate_group(tail, func)
    end
  end

  def get_group(group_id) do
    Repo.get(Group, group_id)
  end

  def create_group(group_name) do
    Repo.insert(%Group{group_name: group_name})
  end

  def delete_group(group_id) do
    validate_group([group_id], fn ->
      Repo.update(Group.changeset(get_group(group_id), %{deleted: true}))
    end)
  end
end
