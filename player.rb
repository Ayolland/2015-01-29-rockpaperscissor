class Player

  attr_reader :name, :control
  attr_accessor :score, :move

  def initialize(name,control)
    @name = name
    @control = control
    @score = 0
    @move = nil
  end

end

