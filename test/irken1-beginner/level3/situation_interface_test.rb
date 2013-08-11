require "test/test_helper"
require "rubywarrior/irken1-beginner/situation"

module SituationInterfaceTest
  def test_initialize_situation_with_no_arguments_sets_cur_enemy
    @player.initialize_situation
    assert_equal Situation::Defaults.cur_enemy, @player.cur_enemy
  end

  def test_initialize_situation_with_cur_enemy_option_sets_cur_enemy
    @player.initialize_situation(cur_enemy: "Sludge")
    assert_equal "Sludge", @player.cur_enemy
  end
  
  def test_initialize_situation_with_no_arguments_sets_cur_health
    @player.initialize_situation
    assert_equal Situation::Defaults.cur_health, @player.cur_health
  end

  def test_initialize_situation_with_cur_health_options_sets_cur_health
    @player.initialize_situation(cur_health: 1)
    assert_equal 1, @player.cur_health
  end

  def test_initialize_situation_with_no_arguments_sets_cur_location
    @player.initialize_situation
    assert_equal Situation::Defaults.cur_location, @player.cur_location
  end

  def test_initialize_situation_with_cur_location_sets_cur_location
    @player.initialize_situation(cur_location: :fake_location_data)
    assert_equal :fake_location_data, @player.cur_location
  end

  def test_determine_current_situation_sets_cur_health
    @player.determine_current_situation
    assert_equal @warrior.health, @player.cur_health
  end

  def test_determine_current_situation_sets_cur_location
    expected = [:forward, :backward, :right, :left].inject({}) do |hsh, dir|
      hsh[dir] = @space; hsh
    end
    @player.determine_current_situation
    assert_equal expected, @player.cur_location
  end

  def test_when_forward_is_nothing_determine_current_situation_sets_cur_enemy
    @player.determine_current_situation
    assert_nil @player.cur_enemy
  end

  def test_when_forward_is_enemy_determine_current_situation_sets_cur_enemy
    stub(@space).to_s { "Sludge" }
    @player.determine_current_situation
    assert_equal @space, @player.cur_enemy
  end
end
