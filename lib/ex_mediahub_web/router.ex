defmodule MediaHubWeb.Router do
  use MediaHubWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MediaHubWeb do
    pipe_through :browser

    # get "/", PageController, :index
    get "/", CourseController, :index

    resources "/courses", CourseController
    live "/live-courses", CourseLive.Index
    live "/live-courses/new", CourseLive.New
    live "/top", TopLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", MediaHubWeb do
  #   pipe_through :api
  # end
end
