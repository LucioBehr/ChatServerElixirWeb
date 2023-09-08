defmodule MultiUserChatServerPhoenix.Models.Groups do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :group_name, :string

    has_many :users_groups, MultiUserChatServerPhoenix.Models.UsersGroups, foreign_key: :group_id
    has_many :priv_messages, MultiUserChatServerPhoenix.Models.PrivMessages, foreign_key: :group_id
    has_many :group_messages, MultiUserChatServerPhoenix.Models.GroupMessages, foreign_key: :group_id

    has_many :users, through: [:users_groups, :user]

    timestamps()
  end

  def changeset(group, params \\ %{}) do
    group
    |> cast(params, [:group_name])
    |> validate_required([:group_name])
  end
end
