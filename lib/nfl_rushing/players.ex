defmodule NflRushing.Players do
  use Agent
  alias NflRushing.{Player, PlayerRepository, PlayerImport}

  @doc """
  Starts the Players Agent
  """
  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(_) do
    Agent.start_link(&read_json!/0, name: __MODULE__)
  end

  @doc """
  Loads the `rushing.json` file in the agent.

  Is run by default when starting the agent but can be manually called to refresh the records
  """
  @spec load :: :ok
  def load do
    Agent.update(__MODULE__, fn _ -> read_json!() end)
  end

  @doc """
  Gets the first player from the store.

  Returns nil if no player has been loaded
  """
  @spec first :: Player.t() | nil
  def first() do
    Agent.get(__MODULE__, &List.first/1)
  end

  @doc """
  Fetches players according to given filters in the store.

  See PlayerRepository.all/2 for more details about filtering
  """
  def fetch(params \\ %{}) do
    Agent.get(__MODULE__, &PlayerRepository.all(&1, params))
  end

  defp read_json!() do
    json_file_path()
    |> File.read!()
    |> Jason.decode!()
    |> PlayerImport.import_from()
  end

  defp json_file_path, do: NflRushing.Application.priv_path(["rushing.json"])
end
