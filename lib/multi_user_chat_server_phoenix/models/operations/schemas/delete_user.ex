defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.DeleteUser do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_id]

  @derive {Jason.Encoder, only: [:user_id]}
  embedded_schema do
    field :user_id, :integer
    field :operation, :string, default: "delete_user"
    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_params ++ [:operation])
    |> validate_required(@required_params)
  end
end
