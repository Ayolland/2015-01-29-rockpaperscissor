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
    @throw = 0 if throw_name.upcase == 'ROCK' 
    @throw = 1 if throw_name.upcase == 'PAPER'
    @throw = 2 if (throw_name.upcase == 'SCISSOR') || (throw_name.upcase == 'SCISSORS')
  end
  
  def ai_random
    random_throw = Random.new
    @throw = random_throw.rand(3)
  end
  
end

class Match
  
  def initialize(player1,player2,win_condition)
    @player1 = player1
    @player2 = player 2
    @win_at = win_condition.to_i
    @win_at = 5 if @win_at > 5
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
  puts "Sorry. One more time:" if control == nil
  control
end

#uses driver_ask_name and driver_ask_bot to build a new Player object

def driver_build_player(pstring)
  pname = driver_ask_name(pstring)
  pbot = driver_ask_bot(pstring)
  while pbot == nil
    pbot = driver_ask_bot(pstring)
  end
  Player.new(pname,pbot)
end


#main driver, sets up two player objects

def driver
  puts "This is a Rock Paper Scissors game."
  p1 = driver_build_player('One')
  p2 = driver_build_player('Two')
  puts 'Okay!'
  puts p1.name + ": " + p1.control + " >VERSUS< " + p2.name + ": " + p2.control
end

binding.pry

