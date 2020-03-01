defmodule CheerlandApiWeb.Router do
  use CheerlandApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CheerlandApiWeb do
    pipe_through :api

    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
  end
end
