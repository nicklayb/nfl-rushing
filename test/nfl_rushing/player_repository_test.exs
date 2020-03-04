defmodule NflRushingWeb.PlayerRepositoryTest do
  use NflRushingWeb.TestCase
  alias NflRushing.{Player, PlayerRepository}

  describe("PlayerRepository.all/1") do
    test("should return the whole list no params are given") do
      players = PlayerRepository.all(mock_players())
      [player | _] = players

      assert ^player = %Player{
        name: "Eli Manning",
        yards: 1,
        rushing_touchdowns: 3,
        longest_rush: "3",
      }

      assert Enum.count(players) == Enum.count(mock_players())
    end

    test("should filter by name") do
      players = PlayerRepository.all(mock_players(), %{"search" => "Eli"})

      assert [%Player{name: "Eli Manning"}] = players
    end

    test("should sort by any fields") do
      by_yards = PlayerRepository.all(mock_players(), %{"sort" => "yards"})
      by_rushing_touchdowns = PlayerRepository.all(mock_players(), %{"sort" => "rushing_touchdowns"})
      by_longest_rush = PlayerRepository.all(mock_players(), %{"sort" => "longest_rush"})

      assert [%Player{name: "Eli Manning"} | _] = by_yards
      assert [%Player{name: "Laurent Duvernay-Tardif"} | _] = by_rushing_touchdowns
      assert [%Player{name: "Patrick Mahomes"} | _] = by_longest_rush
    end
  end

  def mock_players do
    [
      %Player{
        name: "Eli Manning",
        yards: 1,
        rushing_touchdowns: 3,
        longest_rush: "3",
      },
      %Player{
        name: "Patrick Mahomes",
        yards: 2,
        rushing_touchdowns: 2,
        longest_rush: "1T",
      },
      %Player{
        name: "Laurent Duvernay-Tardif",
        yards: 3,
        rushing_touchdowns: 1,
        longest_rush: "2T",
      },
    ]
  end
end
