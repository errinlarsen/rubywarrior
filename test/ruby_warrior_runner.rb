require "ruby_warrior"

module RubyWarriorRunner
  attr_reader :rw_runner, :rw_output, :rw_error
  alias_method :ruby_warrior_runner, :rw_runner
  alias_method :ruby_warrior_output, :rw_output
  alias_method :ruby_warrior_error, :rw_error

  def run_ruby_warrior
    @rw_runner = RubyWarrior::Runner.new(rw_cli_args, STDIN, STDOUT)
    @rw_output, @rw_error = capture_subprocess_io { rw_runner.run }
  end


  private
  def rw_cli_args
    return %w[-d rubywarrior/irken1-beginner -s -t 0]
  end

  def level_score
    match_data = /^Level Score: (?<score>\d+)$/.match(rw_output)
    return match_data[:score].to_i
  end

  def time_bonus
    match_data = /^Time Bonus: (?<bonus>\d+)$/.match(rw_output)
    return match_data[:bonus].to_i
  end

  def clear_bonus
    match_data = /^Clear Bonus: (?<bonus>\d+)$/.match(rw_output)
    return match_data[:bonus].to_i
  end

  def total_score
    match_data = /^Total Score.*= (?<score>\d+)$/.match(rw_output)
    return match_data[:score].to_i
  end
end


module Minitest
  module Assertions
    def assert_ruby_warrior_output_includes(obj, msg = nil)
      assert_includes(rw_output, obj, msg)
    end

    def refute_ruby_warrior_output_includes(obj, msg = nil)
      refute_includes(rw_output, obj, msg)
    end

    def assert_ruby_warrior_level_score_meets_or_beats(score)
      assert_operator score, :<=, level_score
    end

    def assert_ruby_warrior_time_bonus_meets_or_beats(bonus)
      assert_operator bonus, :<=, time_bonus
    end

    def assert_ruby_warrior_clear_bonus_meets_or_beats(bonus)
      assert_operator bonus, :<=, clear_bonus
    end

    def assert_ruby_warrior_total_score_meets_or_beats(score)
      assert_operator score, :<=, total_score
    end
  end
end
