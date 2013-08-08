require "test/test_helper"
require "stringio"
require "ruby_warrior"

class AcceptanceTest < Minitest::Test
  def setup
    cli_arguments = ["-d", "rubywarrior/irken1-beginner", "-s", "-t", "0"]
    @stdin = StringIO.new
    @stdout = StringIO.new
    @runner = RubyWarrior::Runner.new(cli_arguments, @stdin, @stdout)
  end

  def test_level_1
    @runner.run
    puts "STDOUT ==> #{@stdout.string}"
    assert_includes @stdout.string, "Success! You have found the stairs."
  end
end
