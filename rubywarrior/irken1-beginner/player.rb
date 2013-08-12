require_relative "brain"

class Player
  include Brain

  attr_reader :warrior

  def initialize(warrior, options = {})
    @warrior = warrior
    initialize_brain(options)
  end

  def play_turn(warrior)
    @warrior = warrior
    determine_current_situation
    warrior.send(*determine_action_and_arguments)
  end
end
