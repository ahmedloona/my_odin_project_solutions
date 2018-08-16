require 'byebug'

class Board

  attr_accessor :grid

  def initialize(grid = nil)

    grid ||= Array.new(3) { [nil] * 3 }
    @grid = grid
  end

  def place_mark(pos, mark)
    row, col = pos
    grid[row][col] = mark if empty?(pos)
  end

  def empty?(pos)
    row, col = pos
    grid[row][col].nil?
  end

  def winner

    rows = grid
    cols = grid.transpose
    diag_1 = [grid[0][0], grid[1][1], grid[2][2]]
    diag_2 = [grid[2][0], grid[1][1], grid[0][2]]
    checks = rows + cols + [diag_1, diag_2]

    checks.each do |triple|
      return :X if triple == [:X] * 3
      return :O if triple == [:O] * 3
    end

    nil
  end

  def over?

    grid.flatten.none? {|pos| pos.nil?} || winner
  end

end
