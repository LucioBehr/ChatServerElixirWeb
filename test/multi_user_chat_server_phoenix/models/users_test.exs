defmodule MultiUserChatServerPhoenix.Models.UsersTest do
  use MultiUserChatServerPhoenix.DataCase, async: true
  alias MultiUserChatServerPhoenix.Models.Users

  setup do
    {:ok, user} = Users.create_user("test_user")
    user_id = Map.get(user, :id)
    %{user_id: user_id, user: user}
  end

  describe "create_user/1" do
    test "creates a valid user" do
      assert {:ok, user} = Users.create_user("test_user")
      assert user.user_name == "test_user"
    end

    test "creates a user using a blank name" do
      assert {:error, %_{errors: [user_name: {"can't be blank", _}]}} = Users.create_user("")
    end

    test "creates a user using a invalid type" do
      assert {:error, %_{errors: [user_name: {"is invalid", _}]}} = Users.create_user(2)
    end

  end

  describe "get_user/1" do
    test "getting a valid user by id", %{user_id: user_id, user: user} do
      assert {:ok, user} = Users.get_user(user_id)
    end
    test "getting an invalid user by id", %{user_id: user_id, user: user} do
      assert {:error, :missing_user} = Users.get_user(user_id+1)
    end
  end

  describe "delete_user/1" do
    test "delete a valid user by id", %{user_id: user_id, user: user} do
      assert {:ok, user} = Users.delete_user(user_id)
    end

    test "delete an invalid user by id", %{user_id: user_id, user: user} do
      assert {:error, :missing_user} = Users.delete_user(user_id+1)
    end
  end

  describe "update_last_checked_at/1" do
    test "update last checked at for a valid user by id", %{user_id: user_id, user: user} do
      assert {:ok, user} = Users.update_last_checked_at(user_id)
    end

    test "update last checked at for an invalid user by id", %{user_id: user_id, user: user} do
      assert {:error, :missing_user} = Users.update_last_checked_at(user_id+1)
    end
  end

  describe "alter_user_name/1" do
    test "alter name for a valid user by id", %{user_id: user_id, user: user} do
      assert {:ok, user} = Users.alter_user_name(user_id, "new_name")
    end
    test "alter name for an invalid user by id", %{user_id: user_id, user: user} do
      assert {:error, :missing_user} = Users.alter_user_name(user_id+1, "new_name")
    end
    test "alter name for a valid user by id using a blank name", %{user_id: user_id, user: user} do
      assert {:error, %_{errors: [user_name: {"can't be blank", _}]}} = Users.alter_user_name(user_id, "")
    end
    test "alter name for a valid user by id using an invalid type", %{user_id: user_id, user: user} do
      assert {:error, %_{errors: [user_name: {"is invalid", _}]}} = Users.alter_user_name(user_id, 2)
    end
  end
end
