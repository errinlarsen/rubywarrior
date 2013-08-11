module Knowledge
  attr_reader :cur_health, :max_damage, :max_health, :units

  def initialize_knowledge(options = {})
    @units      = options[:units]      || default_units
    @max_damage = options[:max_damage] || units["Warrior"][:max_damage]
    @max_health = options[:max_health] || units["Warrior"][:max_health]
  end

  def turns_needed_to_kill(enemy_name)
    return 0 if %w[nothing wall].include?(enemy_name)
    enemy = units[enemy_name]
    min_turns = enemy[:max_health] / max_damage
    min_turns += 1 unless enemy[:max_health] % max_damage == 0
    return min_turns
  end

  def health_needed_to_kill(space)
    name = space.to_s
    return 0 if space.nil? || %w[nothing wall].include?(name)
    turns_enemy_does_damage = turns_needed_to_kill(name) - 1
    min_health = turns_enemy_does_damage * units[name][:max_damage]
    return min_health + 1
  end

  def directions
    return [:forward, :right, :backward, :left]
  end

  private
  def default_units
    return {
      "Warrior" => {max_damage: 5, max_health: 20},
      "Sludge"  => {max_damage: 3, max_health: 12}
    }
  end
end

