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

  def test_level_1
    @runner.run
    success_msg = "Success! You have found the stairs."
    assert_includes @stdout.string, success_msg, stdout_failure_msg(@stdout)
  end
end
