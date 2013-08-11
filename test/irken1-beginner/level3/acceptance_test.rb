require "test/test_helper"
require "minitest_ruby_warrior"

class AcceptanceTest < Minitest::Test
  include MinitestRubyWarrior::Runner

  def setup
    run_ruby_warrior
  end

  def test_level_is_successful
    assert_ruby_warrior_output_includes "Success! You have found the stairs."
  end

  def test_player_does_not_die
    refute_ruby_warrior_output_includes "irken1 dies"
  end

  def test_gained_best_level_score
    assert_ruby_warrior_level_score_meets_or_beats 12
  end

  def test_gained_best_time_bonus
    assert_ruby_warrior_time_bonus_meets_or_beats 10
  end

  def test_gained_best_clear_bonus
    assert_ruby_warrior_clear_bonus_meets_or_beats 4
  end

  def test_gained_best_total_score
    assert_ruby_warrior_total_score_meets_or_beats 36
  end
end
