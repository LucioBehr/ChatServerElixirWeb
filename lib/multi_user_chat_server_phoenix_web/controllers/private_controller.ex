defmodule MultiUserChatServerPhoenixWeb.PrivateController do
  use MultiUserChatServerPhoenixWeb, :controller

  alias MultiUserChatServerPhoenix, as: Server

  def create_user(conn, params) do
    response =
      Server.create_user(params["name"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_all(conn, _params) do
    response =
      Server.get_all()
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def delete_user(conn, params) do
    response =
      Server.delete_user(params["user_id"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def alter_name(conn, params) do
    response =
      Server.alter_name(params["user_id"], params["new_user_name"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_user(conn, params) do
    response =
      Server.get_user(params["user_id"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_all_users(conn, _params) do
    response =
      Server.get_user()
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_messages(conn, params) do
    response =
      Server.get_messages(params["user_id"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_all_messages(conn, _params) do
    response =
      Server.get_messages()
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_pending_messages(conn, params) do
    response =
      Server.get_pending_messages(params["user_id"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def get_received_messages(conn, params) do
    response =
      Server.get_received(params["user_id"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end

  def send_priv_message(conn, params) do
    response =
      Server.send_priv_message(params["user_id_from"], params["user_id_to"], params["content"])
      |> Jason.encode!()

    send_resp(conn, 200, response)
  end
end
