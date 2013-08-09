class Player
  def play_turn(warrior)
    next_space = warrior.feel

    if next_space.empty?
      warrior.walk!
    else
      warrior.attack!
    end
  end
end
