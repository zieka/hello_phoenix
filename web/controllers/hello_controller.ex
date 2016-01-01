defmodule HelloPhoenix.HelloController do
  use HelloPhoenix.Web, :controller

	plug :assign_welcome_message, "Welcome Back" when action in [:index, :show]

  def index(conn, _params) do
		# render conn, "index.html"

		conn
  	#|> assign(:message, "Welcome Back!")

  	|> assign(:name, "What is your name?")
  	#|> render("index.html")

  	#|> put_resp_content_type("text/plain")
  	#|> send_resp(201, "")

  	|> put_layout(false)  # parethesis very important
  	|> render "index.html"
  end

  defp assign_welcome_message(conn, msg) do
  	assign(conn, :message, msg)
	end

	def show(conn, %{"messenger" => messenger}) do
  	render conn, "show.html", messenger: messenger
	end
end

# HelloController requires HelloView,
# and HelloView requires the existence of the
# web/templates/hello directory,
# which must contain the show.html.eex template.