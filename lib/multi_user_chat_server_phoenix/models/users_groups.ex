defmodule MultiUserChatServerPhoenix.Models.UsersGroups do
  use Ecto.Schema

  schema "users_groups" do
    belongs_to :user, MultiUserChatServerPhoenix.Models.Users
    belongs_to :group, MultiUserChatServerPhoenix.Models.Groups
    timestamps()
  end
end
