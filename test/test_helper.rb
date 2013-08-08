require "minitest/autorun"
require "rr"

def stdout_failure_msg(stdout)
  formatted = stdout.string.gsub(/^/, " " * 4).gsub(/\.\n\Z/, '')
  return "Output captured:\n#{formatted}"
end
