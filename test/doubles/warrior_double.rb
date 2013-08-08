class WarriorDouble
  attr_reader :abilities, :calls

  def initialize(*abilities)
    @abilities = abilities.uniq
    @calls = Hash.new([])
  end

  def method_missing(m, *args, &block)
    if abilities.include?(m)
      @calls[m] << args
      return [m]
    else
      super
    end
  end

  def respond_to?(m)
    return abilities.include?(m) ? true : super
  end
end
