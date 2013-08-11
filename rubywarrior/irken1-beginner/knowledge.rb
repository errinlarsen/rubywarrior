module Knowledge
  attr_reader :max_damage, :max_health, :units

  def directions
    return [:forward, :right, :backward, :left]
  end

  def initialize_knowledge(options = {})
    @units      = options[:units]      || Defaults.units
    @max_damage = options[:max_damage] || units["Warrior"][:max_damage]
    @max_health = options[:max_health] || units["Warrior"][:max_health]
  end

  def health_needed_to_kill(unit)
    return 0 if unit.nil? || %w[nothing wall].include?(unit.to_s)
    turns_needed = turns_needed_to_kill(unit) - 1
    exact_health_needed = turns_needed * units[unit.to_s][:max_damage]
    return exact_health_needed + 1
  end

  def turns_needed_to_kill(unit)
    return 0 if unit.nil? || %w[nothing wall].include?(unit.to_s)
    min_turns = units[unit.to_s][:max_health] / max_damage
    min_turns += 1 unless units[unit.to_s][:max_health] % max_damage == 0
    return min_turns
  end

  module Defaults
    def self.units
      return {
        "Warrior" => {max_damage: 5, max_health: 20},
        "Sludge"  => {max_damage: 3, max_health: 12}
      }
    end
  end
end
