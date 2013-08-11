require "test/test_helper"
require "rubywarrior/irken1-beginner/brain"
require_relative "knowledge_interface_test"
require_relative "situation_interface_test"

module BrainInterfaceTest
  include KnowledgeInterfaceTest
  include SituationInterfaceTest
end
