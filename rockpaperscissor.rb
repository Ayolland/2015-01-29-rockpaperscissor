require 'pry'

class Player
  
  attr_reader :name, :control
  
  def initialize(name,control)
    @name = name
    @throw = nil
    @wins = 0
    @losses = 0  
    @control = control
  end
  
  def set_throw(throw_name)
    @throw = 0 if throw_name == 'ROCK' 
    @throw = 1 if throw_name == 'PAPER'
    @throw = 2 if (throw_name == 'SCISSOR')
    @throw
  end
  
  def ai_random
    random_throw = Random.new
    @throw = random_throw.rand(3)
    @throw
  end
  
end

class Match
  
  attr_reader :player1, :player2, :win_at
  
  def initialize(player1,player2,win_condition)
    @player1 = player1
    @player2 = player2
    @win_at = win_condition
    @p1points = 0
    @p2points =0
  end
  
  def test_winner
    winner = nil
    winner = @player1.name if @p1points == @win_at
    winner = @player2.name if @p2points == @win_at
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
  control = nil if !((control == "HUMAN")||(control == "COMPUTER"))
  driver_wrong_input(control)
  control
end

def driver_wrong_input_loop(input_method,input)
  notnil = input_method(input)
  while notnil == nil
    notnil = input_method(input)
  end
end

def driver_wrong_input(input)
    puts "Sorry. One more time:" if input == nil
end

#uses driver_ask_name and driver_ask_bot to build a new Player object

def driver_build_player(pstring)
  pname = driver_ask_name(pstring)
  driver_wrong_input_loop(driver_ask_bot,pstring)
  Player.new(pname,pbot)
end

def d_line
  puts "-" * 40
end

def driver_human_set_throw(player)
  puts player.name + ": select your throw! (ROCK, PAPER, OR SCISSOR)"
  throw = gets.chomp.upcase
  throw = nil if !(((throw == 'ROCK')||(throw == 'PAPER'))||(throw == 'SCISSOR'))
  driver_wrong_input(throw)
  throw
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
  p1.set_throw(driver_human_set_throw(p1)) if p1.control == "HUMAN"
  
end

binding.pry

