require 'pry'

class Player
  
  attr_reader :name, :control
  attr_accessor :hand, :matchpoints, :hand_str
  
  def initialize(name,control)
    @name = name
    @hand = nil
    @hand_str = ""
    @wins = 0
    @losses = 0  
    @control = control
    @matchpoints = 0
  end
  
  def set_hand(hand_name)
    @hand = 0 if hand_name == 'ROCK' 
    @hand = 1 if hand_name == 'PAPER'
    @hand = 2 if (hand_name == 'SCISSOR')
    hand_str = hand_name
  end
  
  def ai_random
    random_hand = Random.new
    @hand = random_hand.rand(3)
    @hand_str = 'ROCK' if @hand == 0
    @hand_str = 'PAPER' if @hand == 1
    @hand_str = 'SCISSOR' if @hand == 2    
    @hand
  end
  
end

class Match
  
  attr_reader :player1, :player2, :win_at
  
  def initialize(player1,player2,win_condition)
    @player1 = player1
    @player2 = player2
    @win_at = win_condition
  end
  
  def test_match_winner
    winner = nil
    winner = @player1 if @player1.matchpoints == @win_at
    winner = @player2 if @player2.matchpoints == @win_at
    winner
  end
  
  def test_round_winner
    winner = nil
    winner = player1 if (player1.hand > player2.hand)
    winner = player2 if (player2.hand > player1.hand)
    winner = player1 if (player1.hand == 0 && player2.hand == 2)
    winner = player2 if (player2.hand == 0 && player1.hand == 2)
    winner = nil if player1.hand == player2.hand
    winner.matchpoints += 1 if winner != nil
    winner
  end
  
end

# prompts for and returns new player's name

def driver_ask_name(pstring)
  puts "Enter Player-" + pstring +"'s name:"
  gets.chomp
end

#prompts for and returns human or computer. all other input returns nil

def driver_ask_bot(pstring)
  puts "Is Player-" + pstring +" a HUMAN or COMPUTER?"
  control = gets.chomp.upcase
  control = "COMPUTER" if control == "COMP"
  control
end

def d_whoops
    puts "Sorry. One more time:"
end

#uses driver_ask_name and driver_ask_bot to build a new Player object

def driver_build_player(pstring)
  pname = driver_ask_name(pstring)
  pbot = driver_ask_bot(pstring)
  while bot_invalid?(pbot)
    d_whoops
    pbot = driver_ask_bot(pstring)
  end
  Player.new(pname,pbot)
end

#checks test against only valid inputs for driver_ask_bot

def bot_invalid?(test)
  test != "HUMAN" && test != "COMPUTER"
end

#writes 60 dashes

def d_line
  puts "-" * 60
end

#prompts human players for their hand as a string

def driver_ask_hand(player)
  puts player.name + ": select your hand! (ROCK, PAPER, OR SCISSOR)"
  hand = gets.chomp.upcase
  hand = "SCISSOR" if hand == "SCISSORS"
  hand
end

#sets a human player's hand by prompting anf then checking the input

def driver_human_set_hand(player)
  h = driver_ask_hand(player)
  while hand_invalid?(h)
    d_whoops
    hand = driver_ask_hand(player)
  end
  player.hand_str = h
  player.hand_str
end

#checks test against only valid inputs for driver_ask_hand

def hand_invalid?(test)
  test != "ROCK" && test != "PAPER" && test != "SCISSOR"
end

#main driver, sets up two player objects

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
  
  p1.set_hand(driver_human_set_hand(p1)) if p1.control == "HUMAN"
  p1.ai_random if p1.control == "COMPUTER"
  p2.set_hand(driver_human_set_hand(p2)) if p2.control == "HUMAN"
  p2.ai_random if p2.control == "COMPUTER"
  d_line
  puts p1.name + " plays " + p1.hand_str
  puts p2.name + " plays " + p2.hand_str
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
  
  puts this_match.test_match_winner.name + " wins the match!" if this_match.test_match_winner != nil
  
  
  
end

binding.pry

