defmodule NflRushingWeb.PlayerView do
  use NflRushingWeb, :view

  def render("index.json", %{players: players}) do
    %{data: render_many(players, __MODULE__, "show.json")}
  end

  def render("show.json", %{player: player}) do
    render_one(player, __MODULE__, "player.json")
  end

  def render("player.json", %{player: player}) do
    player
  end
end
