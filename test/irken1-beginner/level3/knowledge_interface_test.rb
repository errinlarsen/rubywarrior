require "test/test_helper"
require "rubywarrior/irken1-beginner/knowledge"

module KnowledgeInterfaceTest
  def test_directions_returns_an_array_of_the_four_known_directions
    assert_equal [:forward, :right, :backward, :left], @player.directions
  end

  def test_initialize_knowledge_with_no_arguments_sets_units
    @player.initialize_knowledge
    assert_equal Knowledge::Defaults.units, @player.units
  end

  def test_initialize_knowledge_with_units_option_sets_units
    expected = {"Warrior" => {max_damage: 1, max_health: 1}}
    @player.initialize_knowledge(units: expected)
    assert_equal expected, @player.units
  end

  def test_initialize_knowledge_with_no_arguments_sets_max_damage
    expected = Knowledge::Defaults.units["Warrior"][:max_damage]
    @player.initialize_knowledge
    assert_equal expected, @player.max_damage
  end

  def test_initialize_knowledge_with_max_damage_option_sets_max_damage
    @player.initialize_knowledge(max_damage: :fake_max)
    assert_equal :fake_max, @player.max_damage
  end

  def test_initialize_knowledge_with_no_arguments_sets_max_health
    expected = Knowledge::Defaults.units["Warrior"][:max_health]
    @player.initialize_knowledge
    assert_equal expected, @player.max_health
  end

  def test_initialize_knowledge_with_max_health_option_sets_max_health
    @player.initialize_knowledge(max_health: :fake_max)
    assert_equal :fake_max, @player.max_health
  end

  def test_health_needed_to_kill_when_unit_is_nil_returns_zero
    assert_equal 0, @player.health_needed_to_kill(nil)
  end

  def test_health_needed_to_kill_when_unit_is_nothing_returns_zero
    assert_equal 0, @player.health_needed_to_kill("nothing")
  end

  def test_health_needed_to_kill_when_unit_is_wall_returns_zero
    assert_equal 0, @player.health_needed_to_kill("wall")
  end

  def test_turns_needed_to_kill_when_unit_is_nil_returns_zero
    assert_equal 0, @player.turns_needed_to_kill(nil)
  end

  def test_turns_needed_to_kill_when_unit_is_nothing_returns_zero
    assert_equal 0, @player.turns_needed_to_kill("nothing")
  end

  def test_turns_needed_to_kill_when_unit_is_wall_returns_zero
    assert_equal 0, @player.turns_needed_to_kill("wall")
  end

  # Sludge hp: 12, dmg: 3; Warrior dmg: 5
  # Sludge takes: 5x2(turns) + 5(1 more turn) >= 12
  # Warrior takes: 3x2(turns) = 6; 1 more hp to survive ...
  def test_health_needed_to_kill_Sludge_returns_correctly
    expected = 7
    assert_equal expected, @player.health_needed_to_kill("Sludge")
  end

  def test_turns_needed_to_kill_Sludge_returns_correctly
    expected = 3
    assert_equal expected, @player.turns_needed_to_kill("Sludge")
  end
end
