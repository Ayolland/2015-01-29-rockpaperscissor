# Class: RPS_Rules
# Represents the rules and ouputs for RPS games.
#
# Attributtes:
# @beats  - Hash: Keys are RPS moves, values are arrays containing the move the key beats.
# @verb   - Hash: Keys are RPS moves, values are hashes where the key is a move the first
#           key beats, and the value is the attached verb.
# @valid  - Array: contains all valid moves a player can input.
# @prompt - String: Name of the game, use for output.
# 
# Public:
# #random_move
# #play_round

class RPS_Rules
  
  attr_reader :beats, :verb, :valid, :prompt
  
  def initialize
    @beats = {"ROCK" => ["SCISSOR"], "PAPER" => ["ROCK"], "SCISSOR" => ["PAPER"]}
    @verb = {"ROCK" => {"SCISSOR" => "smashes"}, "PAPER" => {"ROCK" => "covers"}, "SCISSOR" => {"PAPER" => "cuts"}}
    @valid = ["ROCK","PAPER","SCISSOR","SCISSORS","RANDOM"]
    @prompt = "Rock, Paper, Scissor"
  end
  
# Public: play_round
# Takes both players, and compares them with @beats to detmine a round's winner.
#
# Parameters:
# p1 - Player: Player 1
# p2 - Player: Player 2
#
# Returns:
# Player: the winning player
  
  def play_round(p1,p2)
    if p1.move == p2.move
      winner = nil
    else
      winner = (@beats[p1.move]).include?(p2.move) ? p1 : p2
    end
    winner
  end
  
# Public: random_move
# Returns a random RPS move
#
# Returns:
# String: Either "ROCK", "PAPER", or "SCISSOR" chosen randomly.

  def random_move
    ["ROCK","PAPER","SCISSOR"].sample
  end
  
end

# Class: RPSLS_Rules
# Represents the rules and ouputs for RPSLS games.
#
# Attributtes:
# @beats  - Hash: Keys are RPS moves, values are arrays containing the move the key beats.
# @verb   - Hash: Keys are RPS moves, values are hashes where the key is a move the first
#           key beats, and the value is the attached verb.
# @valid  - Array: contains all valid moves a player can input.
# @prompt - String: Name of the game, use for output.
# 
# Public:
# #random_move
# #play_round

class RPSLS_Rules
  
  attr_reader :beats, :verb, :valid, :prompt

  def initialize
    @beats = {"ROCK" => ["SCISSOR","LIZARD"], "PAPER" => ["ROCK","SPOCK"], "SCISSOR" => ["PAPER","LIZARD"], "LIZARD" => ["PAPER","SPOCK"], "SPOCK" => ["ROCK","SCISSOR"]}
    @verb = {"ROCK" => {"SCISSOR" => "smashes", "LIZARD" => "crushes"}, "PAPER" => {"ROCK" => "covers", "SPOCK" => "disproves"}, "SCISSOR" => {"PAPER" => "cuts", "LIZARD" => "decapitates"}, "LIZARD" => {"PAPER" => "eats", "SPOCK" => "poisons"}, "SPOCK" => {"ROCK" => "vaporizes", "SCISSOR" => "dissassembles"}}
    @valid = ["ROCK","PAPER","SCISSOR","LIZARD","SPOCK","SCISSOR","RANDOM"]
    @prompt = "Rock, Paper, Scissor, Lizard, Spock"
  end  

# Public: play_round
# Takes both players, and compares them with @beats to detmine a round's winner.
#
# Parameters:
# p1 - Player: Player 1
# p2 - Player: Player 2
#
# Returns:
# Player: the winning player
  
  def play_round(p1,p2)
    if p1.move == p2.move
      winner = nil
    else
      winner = (@beats[p1.move]).include?(p2.move) ? p1 : p2
    end
    winner
  end

# Public: random_move
# Returns a random RPSLS move
#
# Returns:
# String: Either "ROCK", "PAPER", "SCISSOR", "LIZARD", or "SPOCK" chosen randomly.

  def random_move
    ["ROCK","PAPER","SCISSOR","LIZARD","SPOCK"].sample
  end
  
 
end