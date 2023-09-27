defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.EnterGroup do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_id, :group_id]

  @derive {Jason.Encoder, only: [:user_id, :group_id]}
  embedded_schema do
    field :user_id, :integer
    field :group_id, :integer
    field :operation, :string, default: "enter_group"
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
  end
end
