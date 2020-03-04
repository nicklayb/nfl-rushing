defmodule NflRushing.PlayerRepository do
  alias NflRushing.Player
  @doc """
  Filter players according to a map of parameters.

  Parameters can be a map with string keys with the following keys:
  - "search": Search filter that matches player name
  - "sort": Columns to use for sorting the results. If the column is prefixed by a `-`, the results will be descending.
  """
  @filter "search"
  @sort "sort"
  @authorized_sort ~w(yards rushing_touchdowns longest_rush)
  @spec all([Player.t()], map) :: [Player.t()]
  def all(players, params \\ %{}) do
    players
    |> Enum.filter(&filter(&1, Map.get(params, @filter, nil)))
    |> sort(get_sort_param(params))
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

  defp sort(players, {column, ordering}) when is_bitstring(column),
    do: sort(players, {String.to_atom(column), ordering})

  defp sort(players, {column, ordering}) do
    IO.inspect({column, ordering})
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
    |> String.replace(~r/[^0-9]/, "")
    |> String.to_integer()
  end

  defp get_sort_column(player, column), do: Map.get(player, column, 0)

  defp filter(_, nil), do: true

  defp filter(player, value), do: Player.matches?(player, value)
end
