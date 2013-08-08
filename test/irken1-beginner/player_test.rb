require "test/test_helper"
require "rubywarrior/irken1-beginner/player"

class PlayerTest < Minitest::Test
  def setup;
    @player = Player.new
  end

  def test_walk_bang
    @warrior = Minitest::Mock.new
    @warrior.expect :walk!, [:walk!]

    @player.play_turn(@warrior)
    @warrior.verify
  end

  def test_walk_bang_ing_7_times
    #  --------
    # |@      >|
    #  --------
    #   1234567
    expected_steps = 7
    @warrior = WarriorDouble.new(:walk!)

    expected_steps.times { @player.play_turn(@warrior) }
    assert_equal expected_steps, @warrior.calls[:walk!].count
  end
end
