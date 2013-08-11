require "test/test_helper"
require "rubywarrior/irken1-beginner/player"
require_relative "brain_interface_test"

class PlayerTest < Minitest::Test
  include BrainInterfaceTest

  def setup
    @space = Object.new
    stub(@space).to_s { "nothing" }
    stub(@space).enemy? { %w[Sludge].include?(@space.to_s) }
    stub(@space).empty? { %w[nothing wall].include?(@space.enemy?) }

    @warrior = Object.new
    @warrior.instance_variable_set(:@name, "Warrior")
    def @warrior.name; return @name; end
    stub(@warrior).health { 20 }
    [:forward, :backward, :right, :left].each do |direction|
      stub(@warrior).feel(direction) { @space }
    end
    stub(@warrior).attack!
    stub(@warrior).rest!
    stub(@warrior).walk!

    @player = Player.new(@warrior)
  end

  def test_play_turn_calls_warrior_feel_forward
    mock(@warrior).feel(:forward) { @space }
    @player.play_turn(@warrior)
  end

  def test_play_turn_calls_warrior_health
    mock(@warrior).health { 20 }
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_health_is_too_low_calls_warrior_rest_bang
    stub(@warrior).health { 6 }
    mock(@warrior).rest!
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
    stub(@space).to_s { "Sludge" }
    stub(@space).enemy? { true }
    mock(@warrior).attack!
    @player.play_turn(@warrior)
  end

  def test_play_turn_when_space_is_not_empty_does_not_call_warrior_walk_bang
    stub(@space).enemy? { true }
    dont_allow(@warrior).walk!
    @player.play_turn(@warrior)
  end
end
