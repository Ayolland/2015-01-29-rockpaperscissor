require 'pry'
require_relative 'rps_game'
require_relative 'player'

# Public: h_line
# Prints 50 dashes
#
# Returns:
# nil

def h_line
  puts "-" * 50
  nil
end

# Public: check_input
# Prompts for input and checks it against an array of accepted answers.
#
# Parameters:
# valid_inputs - Array: filled with strings of acceptable answers, in all caps
# 
# Returns:
# String: one of the acceptable inputs.

def check_input(valid_inputs)
  input = ""
   loop do
     input = gets.chomp.upcase
   break if (valid_inputs).include?(input)
   puts "Sorry. One more time:"
   end
   return input
 end

# Public: create_player
# Creates a new Player objects using prompts.
#
# Parameters:
# num - The player number. (IE: Player >1<)
# 
# Returns:
# Player: a new player object.

def create_player(num)
  n =num.to_s
  puts "Enter a name for Player " + n + ":"
  name = gets.chomp
  puts "Is Player" + n + " a HUMAN or a COMPUTER?"
  valid = ["HUMAN","COMPUTER","COMP"]
  control = check_input(valid)
  control = "COMPUTER" if control == "COMP"
  Player.new(name,control)
end

# Public: pause
# Prompts a key press before continuing.
#
# Returns:
# nil

def pause
  puts "press any key to continue"
  h_line 
  gets
  nil
end

# Public: play_rps
# Launches a new Rock/Paper/Scissor game
#
# Returns:
# Player: the winning player.

def play_rps
  puts "Ok! Let's play Rock-Paper-Scissors."
  h_line
  p1 = create_player(1)
  p2 = create_player(2)
  h_line
  puts "Great. How many points are you playing to? (1-5)"
  valid = ["1","2","3","4","5"]
  length = check_input(valid).to_i
  this_game = Rps_Game.new(p1,p2,length)
  h_line
  puts "Ok!"
  puts ""
  puts this_game.p1.control + ":" +this_game.p1.name + "> VERSUS <" + this_game.p2.name + ":" + this_game.p2.control
  puts "First to " + length.to_s + " points wins!"
  pause
  this_game.run_game
end

binding.pry