require 'pry'

# Class: Player
#
# Holds info about our game players
#
# Attributes:
# @name         - String: the player's name.
# @hand         - Integer: 0-2 value corresponding to the hand the player is
#                 throwing in a round.
# @hand_str     - String: a stupid stopgap to store the name of the hand.
# @control      - String: Either 'HUMAN' or 'COMPUTER' controlled
# @matchpoints  - String: how many points the player has in the current match.
#
# Public Methods:
# #set_hand()
# #ai_random


class Player
  
  attr_reader :name, :control
  attr_accessor :hand, :matchpoints, :hand_str
  
  def initialize(name,control)
    @name = name
    @hand = [nil,nil]
    @hand_str = ""
    @control = control
    @matchpoints = 0
  end
  
# Public: #set_hand()
# Sets the players hands
#
# Parameters:
# hand_name - the name of the hand the player will throw
#
# Returns:
# Integer: the hand as a 0-2 integer.
#
# State Changes:
# Sets @hand.
  
  def set_hand
    @hand =  [0,'ROCK'] if @hand[0] == 0 || @hand[1] == 'ROCK'
    @hand = [1,'PAPER'] if @hand[0] == 1 || @hand[1] == 'PAPER'
    @hand = [2,'SCISSOR'] if @hand[0] == 2 || @hand[1] == 'SCISSOR'
    @hand
  end
  
# Public: #ai_random
# randomly determines player hand and sets @hand_str to correspond.
#
# Returns:
# Integer: random hand thrown.
#
# State Changes:
# sets @hand and @hand_str.
  
  def ai_random
    r = Random.new
    @hand[0] = r.rand(3)
    @hand[1] = nil
    set_hand
  end
  
end

# Class: Match
#
# Represents a game or series of rounds.
#
# Attributes:
# @player1 - Object: Player object, first player
# @player2 - Object: Player object, second player
# @win_at  - Integer: Points required to win the match.
#
# Public Methods:
# #test_match_winner
# #test_round_winner

class Match
  
  attr_reader :player1, :player2, :win_at
  
  def initialize(player1,player2,win_condition)
    @player1 = player1
    @player2 = player2
    @win_at = win_condition
  end
  
# Public: #test_match_winner
# See if either player has won the match.
#
# Returns:
# Player: Whoever was victorious, nil if none.

  
  def test_match_winner
    winner = nil
    winner = @player1 if @player1.matchpoints == @win_at
    winner = @player2 if @player2.matchpoints == @win_at
    winner
  end
  
# Public: #test_round_winner
# Tests to see which player won the current round.
#
# Returns:
# Player: Whoever was victorious.

  
  def test_round_winner
    winner = nil
    winner = player1 if (player1.hand[0] > player2.hand[0])
    winner = player2 if (player2.hand[0] > player1.hand[0])
    winner = player1 if (player1.hand[0] == 0 && player2.hand[0] == 2)
    winner = player2 if (player2.hand[0] == 0 && player1.hand[0] == 2)
    winner = nil if player1.hand == player2.hand
    winner.matchpoints += 1 if winner != nil
    winner
  end
  
end

# Public: #driver_ask_name
# Prompts for and returns new player's name.
#
# Parameters:
# pstring - String: The number of the player as a string. Because pretty.
#
# Returns:
# String: The name the user enters.

def driver_ask_name(pstring)
  puts "Enter Player-" + pstring +"'s name:"
  gets.chomp
end

# Public: #play
# Prompts for a player's control method.
#
# Parameters:
# pstring - String: The number of the player as a string. Because pretty.
#
# Returns:
# String: the method of control entered.


def driver_ask_bot(pstring)
  puts "Is Player-" + pstring +" a HUMAN or COMPUTER?"
  control = gets.chomp.upcase
  control = "COMPUTER" if control == "COMP"
  control
end

# Public: #d_whoops
# reusuable entry error message.
#
# Returns:
# nil

def d_whoops
    puts "Sorry. One more time:"
end

# Public: #driver_build_player
# Uses driver_ask_name and driver_ask_bot to build a new Player object.
#
# Parameters:
# pstring - String: The number of the player as a string. Because pretty.
#
# Returns:
# Player: the newly created player.
#
# State Changes:
# Initiates a player object.

def driver_build_player(pstring)
  pname = driver_ask_name(pstring)
  pbot = driver_ask_bot(pstring)
  while bot_invalid?(pbot)
    d_whoops
    pbot = driver_ask_bot(pstring)
  end
  Player.new(pname,pbot)
end

# Public: #bot_invalid?
# Checks the string passed to it against valid control options.
#
# Parameters:
# test - String: Passed to it from #driver_ask_bot
#
# Returns:
# Boolean: True means it is a valid control options.

def bot_invalid?(test)
  test != "HUMAN" && test != "COMPUTER"
end

# Public : #d_line
# Reusable horizontal rule.
#
# Returns:
# nil.

def d_line
  puts "-" * 60
end

#prompts human players for their hand as a string

# Public: #driver_ask_hand
# Prompts human players to choose their hand to throw. 
#
# Parameters:
# player - Player: Player whose hand is being chosen. Only accesses their name.
#
# Returns:
# String: The user's inputted hand.

def driver_ask_hand(player)
  puts player.name + ": select your hand! (ROCK, PAPER, OR SCISSOR)"
  player.hand[1] = gets.chomp.upcase
  player.hand[1] = "SCISSOR" if player.hand[1] == "SCISSORS"
  player.hand[1]
end

# Public: #driver_human_set_hand()
# Sets a human player's hand by prompting and then checking the input
#
# Parameters:
# player - Player: The player whose hand is being prompted and set.
#
# Returns:
# String: The hand thrown as a string.
#
# State Changes:
# Sets .hand_str attribute for the given player.

def driver_human_set_hand(player)
  h = driver_ask_hand(player)
  while hand_invalid?(h)
    d_whoops
    h = driver_ask_hand(player)
  end
  player.hand[1] = h
  player.set_hand
  player.hand
end

# Public: #hand_invalid?()
# Checks string passed to it against valid hand inputs.
#
# Parameters:
# test - String: the user input being tested.
#
# Returns:
# Boolean: True if passed string is a valid hand option.

def hand_invalid?(test)
  test != "ROCK" && test != "PAPER" && test != "SCISSOR"
end

# Public: #driver
# Creates a match and two players, loops through matches until a winner is declared.
#
# Returns:
# nil.
#
# State Changes:
# Create 2 player and 1 Match object.

def driver
  puts "This is a Rock Paper Scissors game."
  p1 = driver_build_player('One')
  p2 = driver_build_player('Two')
  puts "How many points will you play to? (Between 1-5)"
  length = gets.chomp.to_i
  length = 1 if length < 1
  length = 5 if length > 5
  puts 'Okay!'
  d_line
  puts p1.name + ": " + p1.control + " >VERSUS< " + p2.name + ": " + p2.control
  this_match = Match.new(p1,p2,length)
  d_line
  while this_match.test_match_winner == nil
    driver_human_set_hand(p1) if p1.control == "HUMAN"
    p1.ai_random if p1.control == "COMPUTER"
    driver_human_set_hand(p2) if p2.control == "HUMAN"
    p2.ai_random if p2.control == "COMPUTER"
    puts p1.name + " plays " + p1.hand[1]
    puts p2.name + " plays " + p2.hand[1]
    this_round = this_match.test_round_winner
    if this_round == nil
      puts "It's a draw!"
    else
      puts this_round.name + " wins this round!"
    end
    d_line
    puts p1.name + ": " + p1.matchpoints.to_s
    puts p2.name + ": " + p2.matchpoints.to_s
    d_line
  end
  winner_name = this_match.test_match_winner.name
  puts winner_name + " wins the match! Congratulations, " + winner_name + "!"
  puts "Good game, everyone!"
  d_line
  
  
  
end

#driver
binding.pry

