defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.Group do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_id, :group_name]

  @derive {Jason.Encoder, only: [:user_id, :group_name]}
  embedded_schema do
    field :user_id, :integer
    field :group_name, :string
    field :operation, :string, default: "create_group"
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
    |> validate_length(:group_name, min: 1)
  end
end
