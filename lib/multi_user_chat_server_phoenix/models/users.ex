defmodule MultiUserChatServerPhoenix.Models.Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :user_name, :string

    has_many :priv_messages, MultiUserChatServerPhoenix.Models.PrivMessages, foreign_key: :user_id
    has_many :group_messages, MultiUserChatServerPhoenix.Models.GroupMessages, foreign_key: :user_id
    has_many :users_groups, MultiUserChatServerPhoenix.Models.UsersGroups, foreign_key: :user_id

    has_many :groups, through: [:users_groups, :group]

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:user_name])
    |> validate_required([:user_name])
  end
end
