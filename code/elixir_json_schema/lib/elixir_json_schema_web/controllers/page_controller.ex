defmodule ElixirJsonSchemaWeb.PageController do
  use ElixirJsonSchemaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
