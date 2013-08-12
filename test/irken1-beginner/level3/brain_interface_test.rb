require "test/test_helper"
require "rubywarrior/irken1-beginner/brain"
require_relative "knowledge_interface_test"
require_relative "situation_interface_test"

module BrainInterfaceTest
  include KnowledgeInterfaceTest
  include SituationInterfaceTest

  def test_determine_action_and_arguments_with_low_health_and_sludge
    stub(@space).to_s { "Sludge" }
    @player.initialize_situation(fake_situation(1))
    assert_equal [:walk!, :backward], @player.determine_action_and_arguments
  end

  def test_determine_action_and_arguments_with_ok_health_and_sludge
    stub(@space).to_s { "Sludge" }
    @player.initialize_situation(fake_situation(7))
    assert_equal [:attack!, :forward], @player.determine_action_and_arguments
  end

  def test_determine_action_and_arguments_with_low_health_cur_enemy_and_nothing
    @player.initialize_situation(fake_situation(1, "Sludge", @space))
    assert_equal [:rest!], @player.determine_action_and_arguments
  end

  def test_determine_action_and_arguments_with_ok_health_cur_enemy_and_nothing
    @player.initialize_situation(fake_situation(7, "Sludge", @space))
    assert_equal [:walk!, :forward], @player.determine_action_and_arguments
  end


  private
  def fake_situation(hp, enemy = nil, loc = nil)
    enemy ||= @space
    loc ||= enemy
    return {cur_health: hp, cur_enemy: enemy, cur_location: {forward: loc}}
  end
end
