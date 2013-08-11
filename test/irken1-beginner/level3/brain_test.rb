require "test/test_helper"
require "rubywarrior/irken1-beginner/brain"

class BrainTest < Minitest::Test
  def setup
    @player = Object.new
    @brain = Brain.new(@player)
  end

  def test_new_brain_sets_its_player
    assert_equal @brain.player, @player
  end

  def test_respond_to_gather_tactical_information
    assert_respond_to @brain, :gather_tactical_information
  end
end
