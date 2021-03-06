defmodule NflRushingWeb.PlayerController do
  use NflRushingWeb, :controller
  alias NflRushing.{PlayerImport, Players}


  @doc """
  Returns a list of players filtered by params
  """
  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    players = Players.fetch(params)

    render(conn, "index.json", %{players: players})
  end

  @doc """
  Exports a list of players filtered by params in CSV format
  """
  @filename "players.csv"
  @spec export(Plug.Conn.t(), map) :: Plug.Conn.t()
  def export(conn, params) do
    csv =
      params
      |> Players.fetch()
      |> create_csv()

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"#{@filename}\"")
    |> send_resp(200, csv)
  end

  defp create_csv(players) do
    players
    |> PlayerImport.export_to()
    |> CSV.encode(headers: true)
    |> Enum.to_list()
    |> to_string()
  end
end
