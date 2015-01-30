require 'pry'
require_relative 'rps_game'
require_relative 'player'

def input_valid?(input,valid_inputs)
  test = false
  valid_inputs.each do |valid_string|
    test = true if input == valid_string
  end
  return test
end

def gets_and_check(valid_inputs)
  input = gets.chomp.upcase
  while !(input_valid?(input,valid_inputs))
    puts "Sorry. One more time:"
    input = gets.chomp.upcase
  end
  input
end

def h_line
  puts "-" * 50
end



def create_rps_player(num)
  n =num.to_s
  puts "Enter a name for Player " + n + ":"
  name = gets.chomp
  puts "Is Player" + n + " a HUMAN or a COMPUTER?"
  valid = ["HUMAN","COMPUTER","COMP"]
  control = gets_and_check(valid)
  Player.new(name,control)
end

def play_rps
  puts "Ok! Let's play Rock-Paper-Scissors."
  h_line
  p1 =create_rps_player(1)
  
  
end

binding.pry