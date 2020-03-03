defmodule NflRushing.Players do
  use Agent
  alias NflRushing.{Player, PlayerImport, Utils}

  def start_link(_) do
    Agent.start_link(&read_json!/0, name: __MODULE__)
  end

  def load do
    Agent.update(__MODULE__, fn _ -> read_json!() end)
  end

  @filter "search"
  @sort "sort"
  @authorized_sort ~w(yards rushing_touchdowns longest_rush)a
  def fetch(params) do
    Agent.get(__MODULE__, fn players ->
      players
      |> Enum.filter(&filter(&1, Map.get(params, @filter, nil)))
      |> sort(get_sort_param(params))
    end)
  end

  defp get_sort_param(params) do
    case Map.get(params, @sort, nil) do
      nil -> nil
      column when column not in @authorized_sort -> nil
      "-" <> column -> {column, :desc}
      column -> {column, :asc}
    end
  end

  defp sort(players, nil), do: players

  defp sort(players, {column, ordering}) do
    Enum.sort(players, fn first, second ->
      [first, second] = Enum.map([first, second], &get_sort_column(&1, column))

      case ordering do
        :asc -> first < second
        :desc -> first > second
      end
    end)
  end

  defp get_sort_column(%Player{longest_rush: longest_rush}, :longest_rush)
       when is_bitstring(longest_rush) do
    longest_rush
    |> String.replace(~r/[0-9]/, "")
    |> String.to_integer()
  end

  defp get_sort_column(player, column), do: Map.get(player, column, 0)

  defp filter(player, nil), do: player

  defp filter(player, value) do
    player.name
    |> String.downcase()
    |> String.contains?(String.downcase(value))
  end

  defp read_json!() do
    json_file_path()
    |> File.read!()
    |> Jason.decode!()
    |> PlayerImport.import_from()
  end

  defp json_file_path, do: NflRushing.Application.priv_path(["rushing.json"])
end
