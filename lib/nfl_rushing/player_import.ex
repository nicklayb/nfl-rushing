defmodule NflRushing.PlayerImport do
  alias NflRushing.Player

  defp init_struct(), do: %Player{}

  @doc """
  Casts a list of map to a list of Player
  """
  @spec import_from(maybe_improper_list | map) :: [Player.t()] | Player.t()
  def import_from(list) when is_list(list), do: Enum.map(list, &import_from/1)

  def import_from(map) when is_map(map) do
    Enum.reduce(map, init_struct(), fn key_value, player ->
      case key_value do
        {"Player", value} ->
          %Player{player | name: value}

        {"Team", value} ->
          %Player{player | team: value}

        {"Pos", value} ->
          %Player{player | position: value}

        {"Att", value} ->
          %Player{player | attempts: value}

        {"Att/G", value} ->
          %Player{player | attempts_per_game: read_float(value)}

        {"Yds", value} ->
          %Player{player | yards: read_int(value)}

        {"Avg", value} ->
          %Player{player | average: read_float(value)}

        {"Yds/G", value} ->
          %Player{player | yards_per_game: read_float(value)}

        {"TD", value} ->
          %Player{player | rushing_touchdowns: value}

        {"Lng", value} ->
          %Player{player | longest_rush: value}

        {"1st", value} ->
          %Player{player | first_downs: value}

        {"1st%", value} ->
          %Player{player | first_downs_percent: read_float(value)}

        {"20+", value} ->
          %Player{player | rushing_plus_20: value}

        {"40+", value} ->
          %Player{player | rushing_plus_40: value}

        {"FUM", value} ->
          %Player{player | fumbles: value}

        _ ->
          player
      end
    end)
  end

  @doc """
  Converts a player structure to serializable map
  """
  @spec export_to([Player.t()] | Player.t()) :: any
  def export_to(list) when is_list(list), do: Enum.map(list, &export_to/1)

  def export_to(%Player{} = player) do
    Enum.reduce(cells(), %{}, fn {field, key}, acc ->
      Map.put(acc, key, Map.get(player, field, ""))
    end)
  end

  defp cells do
    [
      name: "Player",
      team: "Team",
      position: "Pos",
      attempts: "Att",
      attempts_per_game: "Att/G",
      yards: "Yds",
      average: "Avg",
      yards_per_game: "Yds/G",
      rushing_touchdowns: "TD",
      longest_rush: "Lng",
      first_downs: "1st",
      first_downs_percent: "1st%",
      rushing_plus_20: "20+",
      rushing_plus_40: "40+",
      fumbles: "FUM",
    ]
  end

  defp read_int(value) when is_integer(value), do: value

  defp read_int(value), do: String.to_integer(String.replace(value, ~r/[^0-9]/, ""))

  defp read_float(value) when is_float(value), do: value
  defp read_float(value) when is_integer(value), do: value / 1

  defp read_float(value) do
    if String.contains?(value, ".") do
      String.to_float(value)
    else
      read_float(value)
    end
  end
end
