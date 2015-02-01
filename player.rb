# Public: random_rps
# Returns a random move
#
# Returns:
# String: Either "ROCK", "PAPER", or "SCISSOR" chosen randomly.

def random_rps
  ["ROCK","PAPER","SCISSOR"].sample
end

# Class: Player
# This class hold relevant stats for players in the game.
#
# Attributes:
# @name     - String: Player's name.
# @control  - String: "HUMAN" or "COMPUTER".
# @score    - Integer: The player's current score.
# @move     - The player's move in a RPS round.
#
# Public Methods:
# #set_move
# #save_round

class Player

  attr_reader :name, :control
  attr_accessor :score, :move

  def initialize(name)
    @name = name
    @control = "HUMAN"
    @score = 0
    @move = nil
  end
  
# Public: save_round
# Does nothing, but allows AI and human players to be handled identically.
#
# Returns:
# nil
  
  def save_round(theirmove,mymove,winner)
    nil
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
    @move = check_input(["ROCK","PAPER","SCISSOR","SCISSORS","RANDOM"])
    @move = "SCISSOR" if @move == "SCISSORS"
    @move = random_rps if @move == "RANDOM"
    @move
  end
  
end

# Class: Ai_Player
# This class hold relevant stats for AI players in the game.
#
# Attributes:
# @name       - String: Player's name.
# @control    - String: "HUMAN" or "COMPUTER".
# @score      - Integer: The player's current score.
# @move       - String: The player's move in a RPS round.
# @last_round - Array: The results of the previous round.
# @rules      - Hash: represents the RPS rules.
#
# Public methods:
# #set_move
# #save_round
  
class Ai_Player

  attr_reader :name, :control, :last_round, :rules
  attr_accessor :score, :move
 
  def initialize(name)
    @name = name
    @control = "COMPUTER"
    @score = 0
    @move = nil
    @last_round =[]
    @rules = {"ROCK" => ["SCISSOR", "PAPER"] , "PAPER" => ["ROCK", "SCISSOR",], "SCISSOR" => ["PAPER", "ROCK"]}
  end

# Public: set_move
# Uses @rules, a flowchart, and a coin-toss to determine computer's move.
#
# Returns:
# String: the move selected.
# 
# State Changes:
# sets the @ move attribute of the give Player object.
  
  def set_move
    their_move = @last_round[0]
    my_move = @last_round[1]
    if @last_round = [] || @last_round[2] == nil || [true,false].sample
      @move = random_rps
    elsif won_last_round?
        @move = @rules[my_move].sample
    else !won_last_round?
        @move = @rules[their_move].sample
    end
    @move
  end
  
# Public: save_round
# Stores the results of the most recent round to an array.
#
# Parameters:
# their_move - String: The other player's move
# my_move    - String: This player's move
# winner     - Player or Ai_Player: the winner of the last round.
#
# Returns:
# Array: the round stored as an array
# 
# State Changes:
# fills the @last_round array.
  
  def save_round(their_move,my_move,winner)
    @last_round = [their_move,my_move,winner]
    @last_round
  end
  
# Public: won_last_round?
# Tests whether this player won last round.
#
# Returns:
# Boolean: whether this player won last round.

  def won_last_round?
    @last_round.include?(self)
  end

end

