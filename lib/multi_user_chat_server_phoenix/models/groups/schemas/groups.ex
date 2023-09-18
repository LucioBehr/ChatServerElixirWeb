defmodule MultiUserChatServerPhoenix.Models.Groups.Schema.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :group_name, :inserted_at]}
  schema "groups" do
    field :group_name, :string

    field :deleted, :boolean, default: false

    has_many :users_groups, MultiUserChatServerPhoenix.Models.UsersGroups.Schema.UserGroup,
      foreign_key: :group_id

    has_many :group_messages, MultiUserChatServerPhoenix.Models.GroupMessages.Schema.GroupMessage,
      foreign_key: :group_id

    has_many :users, through: [:users_groups, :user]

    timestamps()
  end

  def changeset(group, params \\ %{}) do
    group
    |> cast(params, [:group_name])
    |> validate_required([:group_name])
  end
end
