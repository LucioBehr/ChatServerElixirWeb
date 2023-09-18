defmodule MultiUserChatServerPhoenix.Models.UsersGroups.Schema.UserGroup do
  use Ecto.Schema


  @derive {Jason.Encoder, only: [:user_id, :group_id, :admin]}
  schema "users_groups" do
    field :admin, :boolean, default: false
    belongs_to :user, MultiUserChatServerPhoenix.Models.Users.Schema.User
    belongs_to :group, MultiUserChatServerPhoenix.Models.Groups.Schema.Group
    timestamps()
  end
end
