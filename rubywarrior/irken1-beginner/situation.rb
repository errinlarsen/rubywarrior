module Situation
  attr_reader :cur_enemy, :cur_health, :cur_location

  def initialize_situation(options = {})
    @cur_enemy    = options[:cur_enemy]    || Defaults.cur_enemy
    @cur_health   = options[:cur_health]   || Defaults.cur_health
    @cur_location = options[:cur_location] || Defaults.cur_location
  end

  def determine_current_situation
    # TODO: What if there isn't a warrior set?
    @cur_health = warrior.health

    directions.each do |direction|
      @cur_location[direction] = warrior.feel(direction)
    end

    @cur_enemy = cur_location[:forward] if cur_location[:forward].enemy?
  end

  module Defaults
    def self.cur_enemy
      return nil
    end

    def self.cur_health
      return 20
    end

    def self.cur_location
      return {forward: nil, right: nil, backward: nil, left: nil}
    end
  end
end
