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

  def initialize(name)
    @name = name
    @control = "HUMAN"
    @score = 0
    @move = nil
  end
  
# Public: set_move
# Uses #check_input to set a valid move for the player.
#
# Returns:
# String: the move selected.
# 
# State Changes:
# sets the @ move attribute of the give Player object.
  
  def set_move
    system "clear"
    puts @name + ", select your move: (ROCK, PAPER, or SCISSOR)"
    @move = check_input(["ROCK","PAPER","SCISSOR","SCISSORS"])
    @move = "SCISSOR" if @move == "SCISSORS"
    @move
  end
  
end
  
class Ai_Player

  attr_reader :name, :control
  attr_accessor :score, :move
 
  def initialize(name)
    @name = name
    @control = "COMPUTER"
    @score = 0
    @move = nil
  end
  
  def set_move
    @move = random_rps
    @move
  end

# Public: random_rps
# Returns a random move
#
# Returns:
# String: Either "ROCK", "PAPER", or "SCISSOR" chosen randomly.


  def random_rps
    ["ROCK","PAPER","SCISSOR"].sample
  end

end

