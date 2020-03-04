defmodule NflRushingWeb.PlayerController do
  use NflRushingWeb, :controller
  alias NflRushing.Players

  def index(conn, params) do
    players = Players.fetch(params)

    render(conn, "index.json", %{players: players})
  end
end
