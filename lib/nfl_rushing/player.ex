defmodule NflRushing.Player do
  @derive Jason.Encoder
  defstruct name: nil,
            team: nil,
            position: nil,
            attempts: nil,
            attempts_per_game: nil,
            yards: nil,
            average: nil,
            yards_per_game: nil,
            rushing_touchdowns: nil,
            longest_rush: nil,
            first_downs: nil,
            first_downs_percent: nil,
            rushing_plus_20: nil,
            rushing_plus_40: nil,
            fumbles: nil

  alias NflRushing.Player

  def matches?(%Player{} = player, string) do
    lower = String.downcase(string)

    player.name
    |> String.downcase()
    |> String.contains?(lower)
  end
end
