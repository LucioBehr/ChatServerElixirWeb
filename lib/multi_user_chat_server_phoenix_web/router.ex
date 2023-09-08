defmodule MultiUserChatServerPhoenixWeb.Router do
  use MultiUserChatServerPhoenixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MultiUserChatServerPhoenixWeb do
    pipe_through :api
    post "/create_user", PrivateController, :create_user
    #
    get "/get_all", PrivateController, :get_all
    post "/delete_user", PrivateController, :delete_user
    post "/alter_name", PrivateController, :alter_name
    get "/get_user", PrivateController, :get_user
    get "/get_all_users", PrivateController, :get_all_users
    get "/get_messages", PrivateController, :get_messages
    get "/get_all_messages", PrivateController, :get_all_messages
    get "/get_pending_messages", PrivateController, :get_pending_messages
    get "/get_received_messages", PrivateController, :get_received_messages
    post "/send_private_message", PrivateController, :send_priv_message

    post "/create_group", GroupController, :create_group
    get "/get_group_messages", GroupController, :get_group_messages
    get "/get_all_group_messages", GroupController, :get_all_group_messages
    post "/send_group_message", GroupController, :send_group_message
    post "/enter_group", GroupController, :enter_group
    get "/get_group", GroupController, :get_group
    get "/get_all_groups", GroupController, :get_all_groups
  end
end
