defmodule CheerlandApi.Reservations.ReservationsTest do
  use CheerlandApi.DataCase

  alias CheerlandApi.Reservations

  describe "rooms" do
    alias CheerlandApi.Reservations.Room

    @valid_attrs %{
      description: "some description",
      group: "some group",
      label: "some label",
      max_beds: 42,
      photos_url: "some photos_url",
      women_only: true
    }
    @update_attrs %{
      description: "some updated description",
      group: "some updated group",
      label: "some updated label",
      max_beds: 43,
      photos_url: "some updated photos_url",
      women_only: false
    }
    @invalid_attrs %{
      description: nil,
      group: nil,
      label: nil,
      max_beds: nil,
      photos_url: nil,
      women_only: nil
    }

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reservations.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Reservations.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Reservations.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Reservations.create_room(@valid_attrs)
      assert room.description == "some description"
      assert room.group == "some group"
      assert room.label == "some label"
      assert room.max_beds == 42
      assert room.photos_url == "some photos_url"
      assert room.women_only == true
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Reservations.update_room(room, @update_attrs)
      assert room.description == "some updated description"
      assert room.group == "some updated group"
      assert room.label == "some updated label"
      assert room.max_beds == 43
      assert room.photos_url == "some updated photos_url"
      assert room.women_only == false
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_room(room, @invalid_attrs)
      assert room == Reservations.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Reservations.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Reservations.change_room(room)
    end
  end
end
