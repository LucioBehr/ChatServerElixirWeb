defmodule MultiUserChatServerPhoenixWeb.PrivateController do
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

  def create_user(conn, params) do

    response = Server.create_user(params)
    |> validate_response(fn user_struct ->
      "user #{params["user_name"]} created with id #{user_struct.id}"
    end)

    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def delete_user(conn, params) do
    response = Server.delete_user(params)
    |>validate_response(fn _ -> "user #{params["user_id"]} deleted"end)
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def alter_name(conn, params) do
    response =
      Server.alter_name(params)
      |>validate_response(fn _ -> "User #{params["user_id"]} renamed to #{params["new_user_name"]}"end)
      send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_user(conn, params) do
      response = Server.get_user(params)
      |> validate_response()
      send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_sended_private_messages(conn, params) do
    response = Server.get_sended_private_messages(params)
      |> validate_response()
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_received_private_messages(conn, params) do
    response =
      Server.get_received_private_messages(params)
      |> validate_response()
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def get_pending_messages(conn, params) do
    response =
      Server.get_pending_messages(params)
      |> validate_response()
    send_resp(conn, elem(response, 0), elem(response, 1))
  end

  def send_priv_message(conn, params) do
    response = Server.send_priv_message(params)
    |> validate_response(fn _ -> "message #{params["content"]} sended from user #{params["sender"]} to user #{params["receiver"]}"end)
    send_resp(conn, elem(response, 0), elem(response, 1))
  end
end
