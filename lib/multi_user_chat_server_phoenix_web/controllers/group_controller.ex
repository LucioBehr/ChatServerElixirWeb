defmodule MultiUserChatServerPhoenixWeb.GroupController do
  use MultiUserChatServerPhoenixWeb, :controller

  alias MultiUserChatServerPhoenix, as: Server

  def create_group(conn, params) do
    response =
      Server.create_group(params["user_id"], params["group_name"])
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def get_group_messages(conn, params) do
    response =
      Server.get_group_messages(params["user_id"], params["group_id"])
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def get_all_group_messages(conn, _params) do
    response =
      Server.get_all_group_messages()
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def send_group_message(conn, params) do
    response =
      Server.send_group_message(params["user_id"], params["group_id"], params["content"])
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def enter_group(conn, params) do
    response =
      Server.enter_group(params["user_id"], params["group_id"])
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def get_group(conn, params) do
    response =
      Server.get_group(params["group_id"])
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

  def get_all_groups(conn, _params) do
    response =
      Server.get_group()
      |> Jason.encode!()
      send_resp(conn, 200, response)
  end

end
