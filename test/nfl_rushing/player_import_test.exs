defmodule NflRushingWeb.PlayerImportTest do
  use NflRushingWeb.TestCase
  alias NflRushing.{Player, PlayerImport}

  describe("PlayerImport.import_from/1") do
    test("should put all individual fields in their own key") do
      Enum.each(fields(), fn ({key, field, value}) ->
        player = PlayerImport.import_from(Map.put(%{}, key, value))

        assert Map.get(player, field) == value
        assert %Player{} = player
      end)
    end

    test("should import map lists") do
      assert [%Player{}, %Player{}] = PlayerImport.import_from([%{}, %{}])
    end
  end

  describe("PlayerImport.export_to/1") do
    test("should export a player to a map") do
      Enum.each(fields(), fn ({key, field, value}) ->
        player = PlayerImport.export_to(Map.put(%Player{}, field, value))

        assert Map.get(player, key) == value
      end)
    end
  end

  defp fields do
    [
      {"Player", :name, random(:string)},
      {"Team", :team, random(:string)},
      {"Pos", :position, random(:string)},
      {"Att", :attempts, random(:string)},
      {"Att/G", :attempts_per_game, random(:float)},
      {"Yds", :yards, random(:integer)},
      {"Avg", :average, random(:float)},
      {"Yds/G", :yards_per_game, random(:float)},
      {"TD", :rushing_touchdowns, random(:string)},
      {"Lng", :longest_rush, random(:string)},
      {"1st", :first_downs, random(:string)},
      {"1st%", :first_downs_percent, random(:float)},
      {"20+", :rushing_plus_20, random(:string)},
      {"40+", :rushing_plus_40, random(:string)},
      {"FUM", :fumbles, random(:string)}
    ]
  end

  defp random(:string), do: to_string(random(:float))
  defp random(:float), do: :rand.uniform()
  defp random(:integer), do: round(random(:float))
end
