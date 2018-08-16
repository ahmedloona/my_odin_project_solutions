require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game

  attr_accessor :board, :player_one, :player_two, :current_player

  def initialize(player1, player2)
    @board = Board.new
    @player_one, @player_two = player1, player2
    player_one.mark = :X
    player_two.mark = :O
    @current_player = player_one
  end

  def play
    current_player.display(board)

    until board.over?
      play_turn
    end

    if game_winner
      game_winner.display(board)
      puts "#{game_winner.name} wins!"
    else
      puts "Cat's game"
    end
  end

  def play_turn
    board.place_mark(current_player.get_move, current_player.mark)
    switch_players!
    current_player.display(board)
  end

  def game_winner
    return player_one if board.winner == player_one.mark
    return player_two if board.winner == player_two.mark
    nil
  end

  def switch_players!
    if @current_player == player_one
       @current_player = player_two
    else
       @current_player = player_one
    end
  end

  if $PROGRAM_NAME == __FILE__

    print "Enter your name: "
    name = gets.chomp.strip
    human = HumanPlayer.new(name)
    garry = ComputerPlayer.new('garry')

    new_game = Game.new(human, garry)
    new_game.play
  end

end
