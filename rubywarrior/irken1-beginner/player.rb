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

    if cur_location[:forward].enemy?
      if cur_health < health_needed_to_kill(cur_enemy)
        warrior.walk!(:backward)
      else
        warrior.attack!
      end
    else
      if cur_health < health_needed_to_kill(cur_enemy)
        warrior.rest!
      else
        @cur_enemy = nil
        warrior.walk!
      end
    end
  end
end
