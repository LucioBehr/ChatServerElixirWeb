defmodule MultiUserChatServerPhoenixWeb.GroupController do
  use MultiUserChatServerPhoenixWeb, :controller

  alias MultiUserChatServerPhoenix, as: Server

  def validate_response(response, expected_func) do
    case response do
      {:ok, function_response} -> {200, expected_func.(function_response)}
      {:error, reason} -> {400, to_string(reason)}
    end
  end

  def validate_response(response) do
    case response do
      {:error, reason} -> {400, Jason.encode!(reason)}
      {:ok, function_response} -> {200, Jason.encode!(function_response)}
      function_response -> {200, Jason.encode!(function_response)}
    end
  end

  def create_group(conn, params) do
    response =
      Server.create_group(params)
      |> validate_response(fn group_struct ->
        "group #{params["group_name"]} created with id #{group_struct.id}"
      end)

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_received_group_messages(conn, params) do
    response =
      Server.get_received_group_messages(params)
      |> validate_response()
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_sended_group_messages(conn, params) do
    response =
      Server.get_sended_group_messages(params)
      |> validate_response()

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def send_group_message(conn, params) do
    response =
      Server.send_group_message(params)
      |> validate_response(fn _ ->
        "message #{params["content"]} sent to group #{params["group_id"]}"
      end)
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def enter_group(conn, params) do
    response =
      Server.enter_group(params)
      |> validate_response(fn _ ->
        "user #{params["user_id"]} entered group #{params["group_id"]}"
      end)
    send_resp(conn, elem(response, 0), elem(response, 1))
  end
end
