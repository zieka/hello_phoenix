defmodule HelloPhoenix.UserController do
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

	def show(conn, %{"id" => id}) do
		# text/2, json/2, and html/2 functions require neither a view
		# nor a template to render.

	  # RENDER PLAIN TEXT
	  # text conn, "Showing id #{id}"

	  # RENDER JSON
	  # json conn, %{id: id}

	  # RENDER HTML
	  html conn, """
     <html>
       <head>
          <title>Passing an Id</title>
       </head>
       <body>
         <h2>You sent in:</h2><h1>id #{id}<h1>
       </body>
     </html>
    """
	end
end