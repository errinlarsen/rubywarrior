require "test/test_helper"
require "rubywarrior/irken1-beginner/player"

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new

    @space = Object.new
    stub(@space).empty? { true }

    @warrior = Object.new
    @warrior.instance_variable_set(:@name, "Warrior")
    def @warrior.name; return @name; end
    stub(@warrior).feel { @space }
    stub(@warrior).walk!
    stub(@warrior).attack!
  end

  def test_play_turn_calls_warrior_feel
    mock(@warrior).feel { @space }
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_space_is_empty_calls_warrior_walk_bang
    mock(@warrior).walk!
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_space_is_empty_does_not_call_warrior_attack_bang
    dont_allow(@warrior).attack!
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_space_is_not_empty_calls_warrior_attack_bang
    stub(@space).empty? { false }
    mock(@warrior).attack!
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_space_is_not_empty_does_not_call_warrior_walk_bang
    stub(@space).empty? { false }
    dont_allow(@warrior).walk!
    @player.play_turn(@warrior)
  end
end
