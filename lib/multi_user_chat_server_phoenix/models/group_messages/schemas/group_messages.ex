defmodule MultiUserChatServerPhoenix.Models.GroupMessages.Schema.GroupMessage do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content, :user_id, :group_id]}
  schema "group_messages" do
    field :content, :string
    belongs_to :user, MultiUserChatServerPhoenix.Models.Users.Schema.User
    belongs_to :group, MultiUserChatServerPhoenix.Models.Groups.Schema.Group
    timestamps()
  end

  def changeset(group_message, params \\ %{}) do
    group_message
    |> cast(params, [:content, :user_id, :group_id])
    |> validate_required([:content, :user_id, :group_id])
  end
end
