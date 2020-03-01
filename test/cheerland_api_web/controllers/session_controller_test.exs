defmodule CheerlandApiWeb.SessionControllerTest do
  use CheerlandApiWeb.ConnCase

  alias CheerlandApi.Auth

  @valid_user_attrs %{
    email: "email1@mail.com",
    password: "123456",
    name: "tester",
    gender: "M",
    allowed_group: "A"
  }
  @valid_login_attrs %{email: "email1@mail.com", password: "123456"}
  @wrong_email_attrs %{email: "2@mail.com", password: "123456"}
  @wrong_pass_attrs %{email: "email1@mail.com", password: "wrong password"}

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@valid_user_attrs)
    user
  end

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")

    {:ok, conn: conn}
  end

  describe "create/2" do
    setup [:create_user]

    test "renders token", %{conn: conn} do
      response =
        conn
        |> post(Routes.session_path(conn, :create), user: @valid_login_attrs)
        |> json_response(200)

      assert response["token"] != nil
    end

    test "renders 404 when email doesnt match", %{conn: conn} do
      response =
        conn
        |> post(Routes.session_path(conn, :create), user: @wrong_email_attrs)
        |> json_response(404)

      assert response["errors"] == %{"detail" => "Not Found"}
    end

    test "renders 401 when password doesnt match", %{conn: conn} do
      response =
        conn
        |> post(Routes.session_path(conn, :create), user: @wrong_pass_attrs)
        |> json_response(401)

      assert response["errors"] == %{"detail" => "Unauthorized"}
    end
  end

  describe "delete/1" do
    test "renders no content", %{conn: conn} do
      conn = delete(conn, Routes.session_path(conn, :delete))
      assert response(conn, 204)
    end
  end

  defp create_user(_context) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
