require "test/test_helper"
require "rubywarrior/irken1-beginner/player"
require_relative "brain_interface_test"

class PlayerTest < Minitest::Test
  include BrainInterfaceTest

  def setup
    @space = Object.new
    stub(@space).to_s { "nothing" }
    stub(@space).enemy? { %w[Sludge].include?(@space.to_s) }
    stub(@space).empty? { %w[nothing wall].include?(@space.to_s) }

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

  def test_play_turn_sets_warrior
    @player.play_turn(@warrior)
    assert_equal @warrior, @player.warrior
  end

  def test_play_turn_calls_determine_current_situation
    mock.proxy(@player).determine_current_situation { |result| result }
    @player.play_turn(@warrior)
  end

  def test_play_turn_calls_determine_action_and_arguments
    mock.proxy(@player).determine_action_and_arguments { |result| result }
    @player.play_turn(@warrior)
  end

  def test_play_turn_calls_warrior_send_with_proper_action_and_direction
    mock(@warrior).send.with_any_args do |*args|
      assert args.size > 0
      assert_includes [:attack!, :rest!, :walk!], args.shift
      unless args.empty?
        assert_includes [:forward, :right, :backward, :left, nil], args.last
      end
    end

    @player.play_turn(@warrior)
  end
end
