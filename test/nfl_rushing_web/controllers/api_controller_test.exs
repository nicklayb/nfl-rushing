defmodule NflRushingWeb.ApiControllerTest do
  use NflRushingWeb.ConnCase

  test("GET /", %{conn: conn}) do
    conn = get(conn, "/api")
    assert html_response(conn, 200) =~ "<div id=\"reactRoot\">"
  end
end
