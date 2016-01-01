defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    # render conn, "index.html"

    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")
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