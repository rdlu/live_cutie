defmodule LiveCutieWeb.PageController do
  use LiveCutieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
