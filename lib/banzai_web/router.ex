defmodule BanzaiWeb.Router do
  use BanzaiWeb, :router

  pipeline :api do
    plug :accepts, ["json", "text"]
  end

  scope "/", BanzaiWeb do
    pipe_through :api

    get "/", HealthCheckController, :check
  end

  scope "/api", BanzaiWeb do
    pipe_through :api

    post "/notifications", NotificationController, :create
  end
end
