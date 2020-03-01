defmodule CheerlandApiWeb.Router do
  use CheerlandApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug(CheerlandApiWeb.Guardian.AuthPipeline)
    plug(CheerlandApiWeb.CurrentUserPlug)
  end

  scope "/api", CheerlandApiWeb do
    pipe_through :api

    post("/sessions", SessionController, :create)
    delete("/sessions", SessionController, :delete)

    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/", CheerlandApiWeb do
    pipe_through([:api, :auth])
  end
end
