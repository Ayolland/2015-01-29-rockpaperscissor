class Rps_Game

  attr_reader :p1, :p2, :length

  def initialize(player1,player2,length)
    @p1 = player1
    @p2 = player2
    @length = length
    @winner = nil
    @round = 0
  end
  
  def set_human_move(player)
    puts player.name + ", select your move: (ROCK, PAPER, or SCISSOR)"
    player.move = check_input(["ROCK","PAPER","SCISSOR","SCISSORS"])
    player.move = "SCISSOR" if player.move == "SCISSORS"
  end
  
  def run_round
    system "clear"
    set_human_move(p1) if @p1.control == "HUMAN"
    p1.move = random_rps if @p1.control == "COMPUTER"
    system "clear"
    set_human_move(p2) if @p2.control == "HUMAN"
    p2.move = random_rps if @p2.control == "COMPUTER"
    h_line
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
  end
  
  def run_game
    while @p1.score != @length && @p2.score != @length
      run_round
    end
    @winner = @p1 if @p1.score == @length
    @winner = @p2 if @p2.score == @length
    puts @winner.name + " wins the game! Congratultions!"
    @winner
  end
  
  def random_rps
    ["ROCK","PAPER","SCISSOR"].sample
  end

end