defmodule MultiUserChatServerPhoenix.Models.Users.Repositories.Database do
  alias MultiUserChatServerPhoenix.Models.Users.Schema.User
  alias MultiUserChatServerPhoenix.Repo

  def validate_user([head], func) do
    case Repo.get_by(User, %{id: head, deleted: false}) do
      nil ->
        {:error, :missing_user}

      _ ->
        func.()
    end
  end

  def validate_user([head | tail], func) do
    case Repo.get_by(User, %{id: head, deleted: false}) do
      nil ->
        {:error, :missing_user}

      _ ->
        validate_user(tail, func)
    end
  end

  def get_user(user_id) do
    validate_user([user_id], fn ->
      {:ok, Repo.get_by(User, %{id: user_id})}
    end)
  end

  defp get_user_data(user_id) do
    validate_user([user_id], fn ->
      Repo.get_by(User, %{id: user_id})
    end)
  end

  def create_user(user_name) do
    Repo.insert(
      User.changeset(%User{}, %{user_name: user_name, last_checked_at: NaiveDateTime.utc_now()})
    )
  end

  def delete_user(user_id) do
    validate_user([user_id], fn ->
      Repo.update(User.changeset(get_user_data(user_id), %{deleted: true}))
    end)
  end

  def update_last_checked_at(user_id) do
    get_user_data(user_id)

    validate_user([user_id], fn ->
      Repo.update(User.changeset(get_user_data(user_id), %{last_checked_at: NaiveDateTime.utc_now()}))
    end)
  end

  def alter_user_name(user_id, user_name) do
    validate_user([user_id], fn ->
      Repo.update(User.changeset(get_user_data(user_id), %{user_name: user_name}))
    end)
  end
end
