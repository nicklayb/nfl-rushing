defmodule NflRushing.PlayerRepository do
  alias NflRushing.Player
  @doc """
  Filter players according to a map of parameters.

  Parameters can be a map with string keys with the following keys:
  - "search": Search filter that matches player name
  - "sort": Columns to use for sorting the results. If the column is prefixed by a `-`, the results will be descending.
  - "take": Amount of records to select
  - "skip": Offset for selecting the rows
  """
  @filter "search"
  @sort "sort"
  @skip "skip"
  @take "take"
  @authorized_sort ~w(yards rushing_touchdowns longest_rush)
  @spec all([Player.t()], map) :: [Player.t()]
  def all(players, params \\ %{}) do
    players
    |> Enum.filter(&filter(&1, Map.get(params, @filter, nil)))
    |> sort(get_sort_param(params))
    |> paginate({get_int_param(params, @skip), get_int_param(params, @take)})
  end

  defp paginate(players, {nil, nil}), do: players
  defp paginate(players, {skip, take}) do
    skip = if not is_nil(skip), do: skip, else: 0
    take = if not is_nil(take), do: take, else: Enum.count(players)

    Enum.slice(players, skip, take)
  end

  defp get_int_param(params, key), do: get_int_param(Map.get(params, key))
  defp get_int_param(nil), do: nil
  defp get_int_param(int) when is_integer(int), do: int
  defp get_int_param(string) when is_bitstring(string) do
    String.to_integer(string)
  rescue
    _ -> nil
  end

  defp get_sort_param(params) do
    case Map.get(params, @sort, nil) do
      column when column in @authorized_sort -> {column, :asc}
      "-" <> column when column in @authorized_sort -> {column, :desc}
      _ -> nil
    end
  end

  defp sort(players, nil), do: players

  defp sort(players, {column, ordering}) when is_bitstring(column),
    do: sort(players, {String.to_atom(column), ordering})

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
    |> String.replace(~r/[^0-9\-]/, "")
    |> String.to_integer()
  end

  defp get_sort_column(player, column), do: Map.get(player, column, 0)

  defp filter(_, nil), do: true

  defp filter(player, value), do: Player.matches?(player, value)
end
