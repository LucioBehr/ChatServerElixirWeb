defmodule MultiUserChatServerPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :multi_user_chat_server_phoenix,
    adapter: Ecto.Adapters.Postgres
end
