defmodule LiveViewPersonWeb.Router do
  use LiveViewPersonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveViewPersonWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewPersonWeb do
    pipe_through :browser

    live "/team_members", TeamMemberLive.Index, :index
    live "/team_members/new", TeamMemberLive.Index, :new
    live "/team_members/:id/edit", TeamMemberLive.Index, :edit
    live "/team_members/:id", TeamMemberLive.Index, :show
    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewPersonWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_view_person, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveViewPersonWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
