defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.AlterName do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_id, :new_user_name]

  @derive {Jason.Encoder, only: [:user_id, :new_user_name]}
  embedded_schema do
    field :user_id, :integer
    field :new_user_name, :string
    field :operation, :string, default: "alter_name"
    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_params ++ [:operation])
    |> do_validations(@required_params)
  end

  def do_validations(changeset, required_params) do
    changeset
    |> validate_required(required_params)
    |> validate_length(:new_user_name, min: 1)
    |> validate_number(:user_id, greater_than: 0)
  end
end
