defmodule MultiUserChatServerPhoenix.Models.Operations do
  alias MultiUserChatServerPhoenix.Models.Operations.Schemas.{
    AlterName,
    CreateUser,
    DeleteUser,
    EnterGroup,
    GroupMessage,
    Group,
    PrivateMessage
  }

  alias MultiUSerChatServerPhoenix.Models.Repositories.KafkaProducer

  def start_operation(message_attrs) do
    message_attrs
    |> get_schema_and_changeset()
    |> handle_changeset_result()
  end

  defp get_schema_and_changeset(%{operation: "create_user"} = message_attrs) do
    CreateUser.changeset(%CreateUser{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "delete_user"} = message_attrs) do
    DeleteUser.changeset(%DeleteUser{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "enter_group"} = message_attrs) do
    EnterGroup.changeset(%EnterGroup{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "group_message"} = message_attrs) do
    GroupMessage.changeset(%GroupMessage{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "group"} = message_attrs) do
    Group.changeset(%Group{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "private_message"} = message_attrs) do
    PrivateMessage.changeset(%PrivateMessage{}, message_attrs)
  end

  defp get_schema_and_changeset(%{operation: "alter_name"} = message_attrs) do
    AlterName.changeset(%AlterName{}, message_attrs)
  end

  defp handle_changeset_result(%Ecto.Changeset{valid?: true} = changeset) do
    data = Ecto.Changeset.apply_changes(changeset)
    IO.inspect(data)
    KafkaProducer.operation(data)

    case data.operation do
      "deposit" -> {:ok, "Deposit request sent"}
      "transfer" -> {:ok, "Transfer request sent"}
      "withdraw" -> {:ok, "Withdraw request sent"}
      "freeze" -> {:ok, "Freeze request sent"}
      "unfreeze" -> {:ok, "Unfreeze request sent"}
    end
  end

  defp handle_changeset_result(changeset) do
    {:error, changeset.errors}
  end
end
