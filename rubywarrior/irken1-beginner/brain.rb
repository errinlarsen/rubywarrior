require_relative "knowledge"

class Brain
  include Knowledge

  attr_reader :player

  def initialize(new_player, options = {})
    @player = new_player
    initialize_knowledge(options)
  end

  def gather_tactical_information
    super(player)
  end
end

