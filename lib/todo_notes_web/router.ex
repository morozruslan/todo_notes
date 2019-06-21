defmodule TodoNotesWeb.Router do
  use TodoNotesWeb, :router

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

  scope "/", TodoNotesWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", TodoNotesWeb do
    pipe_through :api

    resources "/", ApiController, except: [:new, :show, :edit]
  end

end
