defmodule MultiUserChatServerPhoenix.Models.GroupsTest do
  use MultiUserChatServerPhoenix.DataCase, async: true
  alias MultiUserChatServerPhoenix.Models.{Users, Groups}

  setup do
    {:ok, group} = Groups.create_group("test_group")
    %{group: group}
  end

  describe "create_group/1" do
    test "creates a valid group" do
      {:ok, group} = Groups.create_group("test_group")
      assert group.group_name == "test_group"
    end
    test "creates a group using a blank name" do
      assert {:error, %_{errors: [group_name: {"can't be blank", _}]}} = Groups.create_group("")
    end
    test "creates a group using a invalid type" do
      assert {:error, %_{errors: [group_name: {"is invalid", _}]}} = Groups.create_group(2)
    end
  end
end
