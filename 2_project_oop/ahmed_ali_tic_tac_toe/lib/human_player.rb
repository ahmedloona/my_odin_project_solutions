class HumanPlayer
  attr_accessor :name, :mark

  def initialize(name)
    name ||= gets.chomp.capitalize
    @name = name
  end

  def get_move
    print "where do you want your next move? Enter row#, col# e.g. 1, 2
    :"
    move = gets.chomp
    [move[0], move[-1]].map(&:to_i)
  end

  def row_format(arr, row_head)
    row_head.zero?? start = "   " : start = "#{row_head - 1} |"
    result = arr.reduce(start) do |acc, el|
        el.nil?? acc << "   |" : acc << " #{el} |"
    end

  end

  def display(board)
    to_print = [[0, 1, 2], board.grid[0], board.grid[1], board.grid[2]]
    formatted = []
    to_print.each_with_index do |row, idx|
      formatted << row_format(row, idx)
    end

    formatted.each do |line|
      puts line, "  -------------"
    end

  end

end
