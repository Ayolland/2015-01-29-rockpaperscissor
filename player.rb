# Class: Player
# This class hold relevant stats for players in the game.
#
# Attributes:
# @name     - String: Player's name.
# @control  - String: "HUMAN" or "COMPUTER".
# @score    - Integer: The player's current score.
# @move     - The player's move in a RPS round.

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

