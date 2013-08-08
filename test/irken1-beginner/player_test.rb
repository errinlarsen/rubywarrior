require "test/test_helper"
require "rubywarrior/irken1-beginner/player"

class PlayerTest < Minitest::Test
  def setup;
    @player = Player.new
    @warrior = Object.new
    stub(@warrior).walk! { [:walk!] }
  end

  def test_play_turn_calls_warrior_walk_bang
    @player.play_turn(@warrior)
    assert_received(@warrior) { |w| w.walk! }
  end
end
