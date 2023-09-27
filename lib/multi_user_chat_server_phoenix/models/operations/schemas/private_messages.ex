defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.PrivateMessage do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:sender_id, :receiver_id, :content]

  @derive {Jason.Encoder, only: [:sender_id, :receiver_id, :content]}
  embedded_schema do
    field :content, :string
    field :sender_id, :integer
    field :receiver_id, :integer
    field :operation, :string, default: "send_private_message"
    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_params ++ [:operation])
    |> do_validations(@required_params)
  end

  def do_validations(changeset, fields) do
    changeset
    |> validate_required(fields)
    |> validate_number(:sender_id, greater_than: 0)
    |> validate_number(:receiver_id, greater_than: 0)
    |> validate_length(:content, min: 1)
  end
end
