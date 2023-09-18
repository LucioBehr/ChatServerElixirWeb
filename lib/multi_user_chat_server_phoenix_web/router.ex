defmodule MultiUserChatServerPhoenixWeb.Router do
  use MultiUserChatServerPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MultiUserChatServerPhoenixWeb do
    pipe_through :api
    post "/create_user", PrivateController, :create_user #ok
    post "/delete_user", PrivateController, :delete_user #ok
    post "/alter_name", PrivateController, :alter_name #ok
    get "/get_user", PrivateController, :get_user #ok
    get "/get_sended_private_messages", PrivateController, :get_sended_private_messages #ok
    get "/get_received_private_messages", PrivateController, :get_received_private_messages #ok
    get "/get_pending_messages", PrivateController, :get_pending_messages #ok
    post "/send_private_message", PrivateController, :send_priv_message #ok

    post "/create_group", GroupController, :create_group #ok
    get "/get_received_group_messages", GroupController, :get_received_group_messages #ok
    get "/get_sended_group_messages", GroupController, :get_sended_group_messages #ok
    post "/send_group_message", GroupController, :send_group_message #ok
    post "/enter_group", GroupController, :enter_group #ok
  end
end
