defmodule MultiUserChatServerPhoenix.Models.PrivMessages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "priv_messages" do
    field :message, :string
    belongs_to :user, MultiUserChatServerPhoenix.Models.Users
    belongs_to :group, MultiUserChatServerPhoenix.Models.Groups
    timestamps()
  end

  def changeset(priv_message, params \\ %{}) do
    priv_message
    |> cast(params, [:message, :user_id, :group_id])
    |> validate_required([:message, :user_id, :group_id])
  end
end
