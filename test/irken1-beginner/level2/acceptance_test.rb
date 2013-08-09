require "test/test_helper"
require "stringio"
require "ruby_warrior"

class AcceptanceTest < Minitest::Test
  def setup
    @stdin = StringIO.new
    @stdout = StringIO.new
    cli_arguments = %w[-d rubywarrior/irken1-beginner -s -t 0]
    @runner = RubyWarrior::Runner.new(cli_arguments, @stdin, @stdout)
  end

  def test_level_is_successful
    @runner.run
    success_msg = "Success! You have found the stairs."
    assert_includes @stdout.string, success_msg, stdout_failure_msg(@stdout)
  end

  def test_player_does_not_die
    @runner.run
    death_msg = "irken1 dies"
    refute_includes @stdout.string, death_msg, stdout_failure_msg(@stdout)
  end

  def test_enemy_dies
    @runner.run
    death_msg = "Sludge dies"
    assert_includes @stdout.string, death_msg, stdout_failure_msg(@stdout)
  end

  def test_gained_best_level_score
    @runner.run
    assert best_level_score <= level_score(@stdout)
  end

  def test_gained_best_time_bonus
    @runner.run
    assert best_time_bonus <= level_score(@stdout)
  end

  def test_gained_best_clear_bonus
    @runner.run
    assert best_clear_bonus <= clear_bonus(@stdout)
  end

  def test_gained_best_total_score
    @runner.run
    assert best_total_score <= total_score(@stdout)
  end


  private
  def best_level_score; return 12; end
  def level_score(string_io)
    m = /^Level Score: (?<score>\d+)$/.match(string_io.string)
    return m[:score].to_i
  end

  def best_time_bonus;  return 10; end
  def time_bonus(string_io)
    m = /^Time Bonus: (?<bonus>\d+)$/.match(string_io.string)
    return m[:bonus].to_i
  end

  def best_clear_bonus; return  4; end
  def clear_bonus(string_io)
    m = /^Clear Bonus: (?<bonus>\d+)$/.match(string_io.string)
    return m[:bonus].to_i
  end

  def best_total_score; return 36; end
  def total_score(string_io)
    m = /^Total Score.*= (?<score>\d+)$/.match(string_io.string)
    return m[:score].to_i
  end
end
