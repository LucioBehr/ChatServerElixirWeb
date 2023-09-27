defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.GroupMessage do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_id, :group_id, :content]

  @derive {Jason.Encoder, only: [:user_id, :group_id, :content]}
  embedded_schema do
    field :content, :string
    field :user_id, :integer
    field :group_id, :integer
    field :operation, :string, default: "send_group_message"
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
    |> validate_number(:user_id, greater_than: 0)
    |> validate_number(:group_id, greater_than: 0)
    |> validate_length(:content, min: 1)
  end
end
