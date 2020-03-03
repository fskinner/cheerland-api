defmodule CheerlandApiWeb.SessionController do
  use CheerlandApiWeb, :controller

  alias CheerlandApi.Auth
  alias CheerlandApi.Auth.User

  plug(:scrub_params, "user" when action in [:create])

  action_fallback(CheerlandApiWeb.FallbackController)

  def create(conn, %{"user" => params}) do
    with {:ok, %User{} = user} <- Auth.get_user_by_email(params["email"]),
         {:ok, token, _} <-
           Auth.authenticate(%{user: user, password: params["password"]}) do
      render(conn, "token.json", token: token)
    else
      {:error, :not_found} ->
        not_found(conn, params)

      {:error, :unauthorized} ->
        unauthorized(conn, params)

      error ->
        IO.inspect(error)
        internal_server_error(conn, params)
    end
  end

  def delete(conn, _params) do
    conn
    |> CheerlandApiWeb.Guardian.Plug.sign_out()
    |> send_resp(:no_content, "")
  end

  def unauthorized(conn, _) do
    conn
    |> put_status(401)
    |> put_view(CheerlandApiWeb.ErrorView)
    |> render("401.json")
  end

  def internal_server_error(conn, _) do
    conn
    |> put_status(500)
    |> put_view(CheerlandApiWeb.ErrorView)
    |> render("500.json")
  end

  def not_found(conn, _) do
    conn
    |> put_status(404)
    |> put_view(CheerlandApiWeb.ErrorView)
    |> render("404.json")
  end
end
