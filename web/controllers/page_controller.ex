defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  #def index(conn, _params) do  # use _ to make params arbitrary
  def index(conn, params) do
    #render conn, "index.html"
		#render conn, "index.text", message: params["message"]
		#redirect conn, to: "/redirect_test"
		#redirect conn, external: "http://elixir-lang.org/"
		#redirect conn, to: redirect_test_path(conn, :redirect_test)
		#redirect conn, external: redirect_test_url(conn, :redirect_test)

    conn
    # |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    # |> put_flash(:error, "Let's pretend we have an error.")
    # |> render("index.html")

    #|> put_layout("admin.html") #this overides default layout
  	#|> render "index.html"


  	#|> put_status(202) #change response status
  	|> render :index, message: params["message"] #render either html or text

  	#CORRECT WAY TO CALL ERROR VIEW
  	#|> put_status(:not_found)
  	#|> render(HelloPhoenix.ErrorView, "404.html")
  end

  def show(conn, %{"id" => id}) do
  	text conn, "Showing id #{id}"
	end

	def redirect_test(conn, _params) do
  	text conn, "Redirect!"
	end

  def test(conn, _params) do
    render conn, "test.html"
  end

end


# review of RESTful
# index - renders a list of all items of the given resource type
# show - renders an individual item by id
# new - renders a form for creating a new item
# create - receives params for one new item and saves it in a datastore
# edit - retrieves an individual item by id and displays it in a form for editing
# update - receives params for one edited item and saves it to a datastore
# delete - receives an id for an item to be deleted and deletes it from a datastore