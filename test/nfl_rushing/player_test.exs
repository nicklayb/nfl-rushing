defmodule NflRushingWeb.PlayerTest do
  use NflRushingWeb.TestCase
  alias NflRushing.Player

  describe("Player.matches?/2") do
    test("should match a given name with the same case") do
      assert true == Player.matches?(%Player{name: "Eli Manning"}, "Eli")
    end

    test("should match a given name with different cases") do
      assert true == Player.matches?(%Player{name: "Eli Manning"}, "eli")
    end

    test("should not match a given name when it should not match") do
      assert false == Player.matches?(%Player{name: "Eli Manning"}, "Mahomes")
    end
  end
end
