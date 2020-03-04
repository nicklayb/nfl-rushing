defmodule NflRushingWeb.Router do
  use NflRushingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NflRushingWeb do
    pipe_through :browser

    get "/", WebappController, :index
  end

  scope "/api", NflRushingWeb do
    pipe_through :api

    get "/players", PlayerController, :index
    get "/players/export", PlayerController, :export
  end
end
