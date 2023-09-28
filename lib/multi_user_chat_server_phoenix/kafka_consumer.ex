defmodule MultiUSerChatServerPhoenix.KafkaConsumer do
  @behaviour :brod_group_subscriber

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def init(_, _args) do
    {:ok, nil}
  end

  def start_link(_), do: start_consumer()

  def start_consumer do
    :brod.start_link_group_subscriber(
      :kafka_client,
      "my_consumer_group",
      ["first"],
      [],
      [],
      TickTakeHome.KafkaConsumer,
      []
    )
  end

  def stop_consumer(pid) do
    :brod_group_subscriber.stop(pid)
  end

  def handle_message(
        _topic,
        _partition,
        {:kafka_message, _offset, operation, payload, _headers, _timestamp, _flags},
        state
      ) do
    IO.puts("Received message payload: #{inspect(Jason.decode!(payload))}")
    message = Jason.decode!(payload)

    process_message(message, operation)
    |> IO.inspect()

    {:ok, state}
  end

  # def handle_message(_topic, _partition, message_set, state) do
  #  for {:kafka_message, _, _, _, value, _, _} <- message_set do
  #    IO.puts("Received message list: #{inspect(value)}")
  #  end
  #  {:ok, state}
  # end

  defp process_message(message, operation) do
    case operation do
      "create_user" ->
        MultiUserChatServerPhoenix.create_user(message)

      "delete_user" ->
        MultiUserChatServerPhoenix.delete_user(message)

      "alter_name" ->
        MultiUserChatServerPhoenix.alter_name(message)

      "get_user" ->
        MultiUserChatServerPhoenix.get_user(message)

      "get_sended_private_messages" ->
        MultiUserChatServerPhoenix.get_sended_private_messages(message)

      "get_received_private_messages" ->
        MultiUserChatServerPhoenix.get_received_private_messages(message)

      "get_pending_messages" ->
        MultiUserChatServerPhoenix.get_pending_messages(message)

      "send_private_message" ->
        MultiUserChatServerPhoenix.send_priv_message(message)

      "create_group" ->
        MultiUserChatServerPhoenix.create_group(message)

      "get_received_group_messages" ->
        MultiUserChatServerPhoenix.get_received_group_messages(message)

      "get_sended_group_messages" ->
        MultiUserChatServerPhoenix.get_sended_group_messages(message)

      "send_group_message" ->
        MultiUserChatServerPhoenix.send_group_message(message)

      "enter_group" ->
        MultiUserChatServerPhoenix.enter_group(message)
    end
  end
end
