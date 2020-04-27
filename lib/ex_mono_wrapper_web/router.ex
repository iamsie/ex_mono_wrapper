defmodule ExMonoWrapperWeb.Router do
  use ExMonoWrapperWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExMonoWrapperWeb do
    pipe_through :api
  end
end
