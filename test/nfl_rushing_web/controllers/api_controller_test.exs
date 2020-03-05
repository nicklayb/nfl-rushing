defmodule NflRushingWeb.ApiControllerTest do
  use NflRushingWeb.ConnCase

  test("GET /", %{conn: conn}) do
    conn = get(conn, "/api/players")
    assert %{"data" => [%{"name" => _} | _]} = json_response(conn, 200)
  end

  @name "Eli Manning"
  test("GET / with search", %{conn: conn}) do
    conn = get(conn, "/api/players", %{search: @name})

    assert %{"data" => [%{"name" => @name} | _]} = json_response(conn, 200)
  end

  @sort "-yards"
  test("GET / with descending sort", %{conn: conn}) do
    conn = get(conn, "/api/players", %{sort: @sort})

    assert %{"data" => [first, second | _]} = json_response(conn, 200)
    assert first["yards"] >= second["yards"]
  end

  @sort "yards"
  test("GET / with ascending sort", %{conn: conn}) do
    conn = get(conn, "/api/players", %{sort: @sort})

    assert %{"data" => [first, second | _]} = json_response(conn, 200)
    assert first["yards"] <= second["yards"]
  end

  @name "Paul Karya"
  test("GET / with params that returns no value", %{conn: conn}) do
    conn = get(conn, "/api/players", %{search: @name})

    assert %{"data" => []} = json_response(conn, 200)
  end
end
