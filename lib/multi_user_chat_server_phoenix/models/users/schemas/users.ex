defmodule MultiUserChatServerPhoenix.Models.Users.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :user_name, :last_checked_at, :inserted_at]}
  schema "users" do
    field :user_name, :string

    field :deleted, :boolean, default: false

    field :last_checked_at, :naive_datetime

    has_many :sender_priv_messages,
             MultiUserChatServerPhoenix.Models.PrivMessages.Schema.PrivMessage,
             foreign_key: :sender_id

    has_many :receiver_priv_messages,
             MultiUserChatServerPhoenix.Models.PrivMessages.Schema.PrivMessage,
             foreign_key: :receiver_id

    has_many :group_messages, MultiUserChatServerPhoenix.Models.GroupMessages.Schema.GroupMessage,
      foreign_key: :user_id

    has_many :users_groups, MultiUserChatServerPhoenix.Models.UsersGroups.Schema.UserGroup,
      foreign_key: :user_id

    has_many :groups, through: [:users_groups, :group]

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:user_name, :deleted, :last_checked_at])
    |> validate_required([:user_name])
  end
end
