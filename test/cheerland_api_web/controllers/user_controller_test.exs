defmodule CheerlandApiWeb.UserControllerTest do
  use CheerlandApiWeb.ConnCase

  alias CheerlandApi.Auth
  alias CheerlandApi.Auth.User

  @create_attrs %{
    allow_couple_bed: true,
    allowed_group: "some allowed_group",
    cancel_bus: true,
    departure_location: "some departure_location",
    departure_time: "some departure_time",
    email: "email@mail.com",
    password: "some password",
    gender: "some gender",
    is_admin: true,
    name: "some name",
    needs_transportation: true,
    reserved_at: ~D[2010-04-17]
  }
  @update_attrs %{
    allow_couple_bed: false,
    allowed_group: "some updated allowed_group",
    cancel_bus: false,
    departure_location: "some updated departure_location",
    departure_time: "some updated departure_time",
    email: "updated@mail.com",
    password: "some updated password",
    gender: "some updated gender",
    is_admin: false,
    name: "some updated name",
    needs_transportation: false,
    reserved_at: ~D[2011-05-18]
  }
  @invalid_attrs %{
    allow_couple_bed: nil,
    allowed_group: nil,
    cancel_bus: nil,
    departure_location: nil,
    departure_time: nil,
    email: nil,
    encrypted_password: nil,
    gender: nil,
    is_admin: nil,
    name: nil,
    needs_transportation: nil,
    reserved_at: nil
  }

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "allow_couple_bed" => true,
               "allowed_group" => "some allowed_group",
               "cancel_bus" => true,
               "departure_location" => "some departure_location",
               "departure_time" => "some departure_time",
               "email" => "email@mail.com",
               "gender" => "some gender",
               "is_admin" => true,
               "name" => "some name",
               "needs_transportation" => true,
               "reserved_at" => "2010-04-17"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "allow_couple_bed" => false,
               "allowed_group" => "some updated allowed_group",
               "cancel_bus" => false,
               "departure_location" => "some updated departure_location",
               "departure_time" => "some updated departure_time",
               "email" => "updated@mail.com",
               "gender" => "some updated gender",
               "is_admin" => false,
               "name" => "some updated name",
               "needs_transportation" => false,
               "reserved_at" => "2011-05-18"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
