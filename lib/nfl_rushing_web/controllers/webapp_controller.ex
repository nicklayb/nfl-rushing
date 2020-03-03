defmodule NflRushingWeb.WebappController do
  use NflRushingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
