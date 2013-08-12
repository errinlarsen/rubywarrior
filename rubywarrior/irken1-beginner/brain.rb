require_relative "knowledge"
require_relative "situation"

module Brain
  include Knowledge
  include Situation

  def initialize_brain(options = {})
    initialize_knowledge(options)
    initialize_situation(options)
  end

  def determine_action_and_arguments
    if cur_location[:forward].enemy?
      if cur_health < health_needed_to_kill(cur_enemy)
        return [:walk!, :backward]
      else
        return [:attack!, :forward]
      end
    else
      if cur_health < health_needed_to_kill(cur_enemy)
        return [:rest!]
      else
        @cur_enemy = nil
        return [:walk!, :forward]
      end
    end
  end
end
