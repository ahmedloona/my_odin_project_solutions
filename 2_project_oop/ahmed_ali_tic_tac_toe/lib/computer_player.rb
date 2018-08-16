require "byebug"

class ComputerPlayer
  attr_accessor :name, :board, :mark
  def initialize(name)
    @name = name
    @mark = nil
  end

  def display(board)
    @board = board
  end

  def get_move
    grid = board.grid.dup
    rows = grid
    cols = grid.transpose
    diag_1 = [grid[0][0], grid[1][1], grid[2][2]]
    diag_2 = [grid[2][0], grid[1][1], grid[0][2]]
    winning_move = []

    rows.each_with_index do |triple, row|
      if triple.compact == [mark] * 2
        triple.each_with_index {|el, i| winning_move[1] = i if el.nil?}
        winning_move[0] = row
      end
    end

    cols.each_with_index do |triple, col|
      if triple.compact == [mark] * 2
        triple.each_with_index {|el, i| winning_move[0] = i if el.nil?}
        winning_move[1] = col
      end
    end

    if diag_1.compact == [mark] * 2
      diag_1.each_with_index {|el, i| winning_move[1] = i if el.nil?}
      winning_move[0] = winning_move[1]
    end

    if diag_2.compact == [mark] * 2
      diag_2.each_with_index {|el, i| winning_move[1] = i if el.nil?}
      winning_move[0] = 2 - winning_move[1]
    end

    winning_move.empty?? random_move : winning_move

  end

  def random_move
    moves = []
    (0..2).each do |row|
      (0..2).each do |col|
        moves << [row, col] if board.grid[row][col].nil?
      end
    end

    moves.sample
  end

end
