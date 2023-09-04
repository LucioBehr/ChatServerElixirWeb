defmodule MultiUserChatServerPhoenixWeb.Groups.Logic do
  def create_group(user_id, group_name, %{groups: groups, group_messages: group_messages, users: users} = state) do
    new_group = %{
      group_id: state.id_group + 1,
      name: group_name,
      users: [user_id],
      admin: [user_id],
      messages: []
    }

    user = Map.get(users, user_id)
    # updated_user = Map.put(user, :group, user.group ++ state.id_group+1)
    updated_user_group = %{user | group: user.group ++ [state.id_group+1]}
    updated_user = Map.put(users, user_id, updated_user_group)
    create_group = Map.put(groups, Integer.to_string(state.id_group+1), new_group)

    {:reply, "group #{state.id_group+1} created", %{state | users: updated_user, groups: create_group, id_group: state.id_group+1, group_messages: Map.put_new(group_messages, state.id_group+1, %{})}}
  end

  def get_group_messages(user_id, group_id, state) do
    case user_id in Map.get(state, :groups, %{})[group_id][:users] do
      true ->
        messages =
          Map.get(state, :group_messages, %{})
          |> Map.get(group_id, %{})
          |> Enum.map(fn {_, message} -> message end)
        {:reply, messages, state}
      false ->
        {:reply, "user #{user_id} is not in group #{group_id}", state}
      end
  end

  def send_group_message(user_id, group_id, content, %{group_messages: group_messages, groups: groups, users: users, id_msg: id_msg} = state) do
    IO.inspect(users)
    IO.inspect(groups)
    case user_id in Map.get(state, :groups, %{})[group_id][:users] do
      true ->
        new_id_msg = id_msg + 1
        message = %{
          user_id: user_id,
          group_id: group_id,
          content: content
        }
        group_sended = Map.get(groups, group_id)

        updated_group = %{group_sended | messages: group_sended.messages ++ [new_id_msg]}

        sender = Map.get(users, user_id)
        |>IO.inspect()
        updated_sender = %{sender | sended_messages: sender.sended_messages ++ [new_id_msg]}
        |>IO.inspect()
        messages = Map.get(group_messages, group_id, %{})
        updated_messages = Map.put(messages, new_id_msg, %{user_id: user_id, content: content})
        |>IO.inspect()
        new_state = %{state | groups: Map.put(groups, group_id, updated_group), id_msg: new_id_msg, users: Map.put(users, user_id, updated_sender), group_messages: Map.put(group_messages, group_id, updated_messages)}
        |>IO.inspect()

        {:reply, message, new_state}
      false ->
        {:reply, "user #{user_id} is not in group #{group_id}", state}
      end
  end

  def enter_group(user_id, group_id, %{groups: groups, users: users} = state) do
    case user_id in Map.get(state, :groups, %{})[group_id][:users] do
      true ->
        {:reply, "user #{user_id} is already in group #{group_id}", state}
      false ->
        group = Map.get(groups, group_id)
        updated_group = %{group | users: group.users ++ [user_id]}
        user = Map.get(users, user_id)
        updated_user = %{user | group: user.group ++ [group_id]}
        new_state = %{state | groups: Map.put(groups, group_id, updated_group), users: Map.put(users, user_id, updated_user)}
        {:reply, "user #{user_id} entered group #{group_id}", new_state}
      end
  end

end
