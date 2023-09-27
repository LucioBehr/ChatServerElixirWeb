defmodule MultiUserChatServerPhoenix.Models.Operations.Schemas.CreateUser do
  use Ecto.Schema
  import Ecto.Changeset
  @required_params [:user_name]

  @derive {Jason.Encoder, only: [:user_name]}
  embedded_schema do
    field :user_name, :string
    field :operation, :string, default: "create_user"
    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, @required_params ++ [:operation])
    |> validate_required(@required_params)
  end
end
