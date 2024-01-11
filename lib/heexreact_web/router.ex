defmodule HeexreactWeb.Router do
  alias Heexreact.Animals
  use HeexreactWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HeexreactWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HeexreactWeb do
    pipe_through :browser

    # get "/", PageController, :home

    scope "/" do
      live_session :animal,
        on_mount: [] do
        live "/", AnimalLive.Index, :index
        live "/new", AnimalLive.Index, :new
        live "/:id/edit", AnimalLive.Index, :edit
        live "/:id", AnimalLive.Index, :show
        live "/:id/show/edit", AnimalLive.Index, :edit
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HeexreactWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:heexreact, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HeexreactWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
