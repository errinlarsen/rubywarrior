require "simple_mock"

class WarriorDouble
  attr_reader :abilities, :called

  def initialize(*abilities)
    @abilities = abilities.uniq
    @called = Hash.new { |hsh, name| hsh[name] = [] }
  end

  def respond_to?(ability, include_private = false)
    if abilities.include?(ability)
      return true
    else
      super
    end
  end

  private
  def method_missing(ability, *args, &block)
    if abilities.include?(ability)
      called[ability] << args
      return [ability]
    else
      super
    end
  end
end
