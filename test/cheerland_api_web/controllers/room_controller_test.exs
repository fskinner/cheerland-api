defmodule CheerlandApiWeb.RoomControllerTest do
  use CheerlandApiWeb.ConnCase

  alias CheerlandApi.Reservations
  alias CheerlandApi.Reservations.Room

  @create_attrs %{
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

  def fixture(:room) do
    {:ok, room} = Reservations.create_room(@create_attrs)
    room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rooms", %{conn: conn} do
      conn = get(conn, Routes.room_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create room" do
    test "renders room when data is valid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.room_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "group" => "some group",
               "label" => "some label",
               "max_beds" => 42,
               "photos_url" => "some photos_url",
               "women_only" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.room_path(conn, :create), room: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update room" do
    setup [:create_room]

    test "renders room when data is valid", %{conn: conn, room: %Room{id: id} = room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.room_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "group" => "some updated group",
               "label" => "some updated label",
               "max_beds" => 43,
               "photos_url" => "some updated photos_url",
               "women_only" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, room: room} do
      conn = put(conn, Routes.room_path(conn, :update, room), room: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete room" do
    setup [:create_room]

    test "deletes chosen room", %{conn: conn, room: room} do
      conn = delete(conn, Routes.room_path(conn, :delete, room))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.room_path(conn, :show, room))
      end
    end
  end

  defp create_room(_) do
    room = fixture(:room)
    {:ok, room: room}
  end
end
