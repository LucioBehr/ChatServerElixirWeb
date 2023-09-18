defmodule MultiUserChatServerPhoenix.Models.PrivMessages.Schema.PrivMessage do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content, :sender_id, :receiver_id, :inserted_at]}
  schema "priv_messages" do
    field :content, :string

    belongs_to :sender, MultiUserChatServerPhoenix.Models.Users.Schema.User,
      foreign_key: :sender_id

    belongs_to :receiver, MultiUserChatServerPhoenix.Models.Users.Schema.User,
      foreign_key: :receiver_id

    timestamps()
  end

  def changeset(priv_message, params \\ %{}) do
    priv_message
    |> cast(params, [:content, :sender_id, :receiver_id])
    |> validate_required([:content, :sender_id, :receiver_id])
  end
end
