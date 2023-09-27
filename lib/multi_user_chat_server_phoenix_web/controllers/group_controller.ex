defmodule MultiUserChatServerPhoenixWeb.GroupController do
  use MultiUserChatServerPhoenixWeb, :controller

  alias MultiUserChatServerPhoenix.Models.Operations

  def create_group(conn, params) do
    response =
      convert_keys_to_atoms(params)
      |>Operations.start_operation()
      |> validate_response(fn group_struct ->
        "group #{params["group_name"]} created with id #{group_struct.id}"
      end)

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_received_group_messages(conn, params) do
    response = convert_keys_to_atoms(params)
      |> insert_operation("get_received_group_messages")
      |> Operations.start_operation()
      |> validate_response()
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_sended_group_messages(conn, params) do
    response =
      convert_keys_to_atoms(params)
      |> insert_operation("")
      |>Operations.start_operation(params)
      |> validate_response()

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def send_group_message(conn, params) do
    response =
      convert_keys_to_atoms(params)
      |> insert_operation("")
      |>Operations.start_operation(params)
      |> validate_response(fn _ ->
        "message #{params["content"]} sent to group #{params["group_id"]}"
      end)

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def enter_group(conn, params) do
    response = convert_keys_to_atoms(params)
      |> insert_operation("")
      |>Operations.start_operation(params)
      |> validate_response(fn _ ->
        "user #{params["user_id"]} entered group #{params["group_id"]}"
      end)

    send_resp(conn, elem(response, 0), elem(response, 1))
  end


  defp validate_response(response, expected_func) do
    case response do
      {:ok, function_response} -> {200, expected_func.(function_response)}
      {:error, reason} -> {400, to_string(reason)}
    end
  end

  defp validate_response(response) do
    case response do
      {:error, reason} -> {400, Jason.encode!(reason)}
      {:ok, function_response} -> {200, Jason.encode!(function_response)}
      #function_response -> {200, Jason.encode!(function_response)}
    end
  end

  defp convert_keys_to_atoms(map), do:
    Enum.reduce(map, %{}, fn {key, value}, acc -> Map.put(acc, String.to_atom(key), value) end)

  defp insert_operation(map, operation), do: Map.put(map, :operation, operation)

end
