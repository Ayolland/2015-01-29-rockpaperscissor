# Class: Rps_game
#
# This class represents a multi-round Rock/Paper/Scissors match.
#
# Attributes:
# @p1     - Player: player 1
# @p2     - Player: player 2
# @length - Integer: the number of points being played to
# @Winner - The winning player after the resolution of all rounds.
# @round  - The number of rounds played so far.
#
# Public Methods
# #set_human_move
# #run_round
# #run_game
# #random_rps

class Rps_Game

  attr_reader :p1, :p2, :length

  def initialize(player1,player2,length)
    @p1 = player1
    @p2 = player2
    @length = length
    @winner = nil
    @round = 0
  end
  
# Public: run_round
# Runs the current round, determines a winner, adds to Player @scores
#
# Returns:
# nil
#
# State Changes:
# Adds to @round and the winning Player's @score
  
  def run_round
    system "clear"
    p1.set_move
    p2.set_move
    #binding.pry
    system "clear"
    winner = nil
    @round += 1
    puts "Round " + @round.to_s 
    puts p1.name + " plays " + p1.move + "."
    puts p2.name + " plays " + p2.move + "."
    winner = p1 if (p1.move == "ROCK" && p2.move == "SCISSOR")||(p1.move == "SCISSOR" && p2.move == "PAPER")||(p1.move == "PAPER" && p2.move == "ROCK")
    winner = p2 if (p2.move == "ROCK" && p1.move == "SCISSOR")||(p2.move == "SCISSOR" && p1.move == "PAPER")||(p2.move == "PAPER" && p1.move == "ROCK")
    puts " "
    puts (winner != nil ? winner.name + " wins the round!" : "It's a draw.")
    winner.score += 1 if winner != nil
    h_line
    puts p1.name + ": " + p1.score.to_s
    puts p2.name + ": " + p2.score.to_s
    pause
    nil
  end
  
# Public: run_game
# Runs the game, repeating rounds until a Player wins.
#
# Returns:
# Player: the winning Player
#
# State Changes:
# changes in Players' @hand and @score as modified by #run_round
  
  def run_game
    while @p1.score != @length && @p2.score != @length
      run_round
    end
    @winner = @p1 if @p1.score == @length
    @winner = @p2 if @p2.score == @length
    puts @winner.name + " wins the game! Congratultions!"
    @winner
  end

end