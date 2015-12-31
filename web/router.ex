# Custom plug

defmodule HelloPhoenix.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end
  def call(conn, default), do: assign(conn, :locale, default)
end

# Router

defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloPhoenix.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # pipeline :review_checks do
  #   plug :ensure_authenticated_user
  #   plug :ensure_user_owns_review
  # end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    #get "/", RootController, :index #example of ambiguous route

    #creates all RESTful routes
    resources "/users", UserController do
      resources "posts", PostController #nested resource 1 to * relation
    end

    #create only RESTful listed
    #resources "posts", PostController, only: [:index, :show]

    #create all RESTful except
    resources "comments", CommentController, except: [:delete]

    resources "/reviews", ReviewController

    # scope "/reviews" do
    #   pipe_through :review_checks #custom pipeline

    #   resources "reviews", ReviewController
    # end
  end

  #perfectly fine to have two scopes defined for the same path
  scope "/", AnotherApp do
    pipe_through :browser

    #resources "posts", PostController
  end

  #Scoped Routes
  scope   "/admin",           #slash(/) is optional; same results
          HelloPhoenix.Admin, #controller prefix (refactor from lines 43-45)
          as: :admin          #make sure admin helper isnt same as user
  do
    pipe_through :browser

    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end


  # Other scopes may use custom stacks.

  # Nested Scope
  scope "/api", HelloPhoenix.Api, as: :api do
    pipe_through :api

    #good for versioned API
    scope "/v1", V1, as: :v1 do
      resources "/images", ImageController
      resources "/reviews", ReviewController
      resources "/users", UserController
    end
  end
end
