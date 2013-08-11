require_relative "knowledge"
require_relative "situation"

module Brain
  include Knowledge
  include Situation

  def initialize_brain(options = {})
    initialize_knowledge(options)
    initialize_situation(options)
  end
end
