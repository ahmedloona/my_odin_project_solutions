require "byebug"
class Code
  attr_reader :pegs

  PEGS = {
    r: "Red",
    g: "Green",
    b: "Blue",
    y: "Yellow",
    o: "Orange",
    p: "Purple"
  }

  def initialize(pegs)
    @pegs = pegs
  end

  def self.parse(string)
    #debugger
    valid = string.chars.all? { |ch| PEGS.include?(ch.downcase.to_sym) }
    if valid
      Code.new(string.chars)
    else
      raise "invalid color string"
    end
  end

  def self.random
    #debugger
    random_pegs = []
    4.times { random_pegs << PEGS.keys.sample.to_s }
    Code.new(random_pegs)
  end

  def [](pos)
    pegs[pos]
  end

  def exact_matches(another_code)
    #debugger
    matches = 0
      self.pegs.each_with_index do |peg, idx|
        if peg == another_code.pegs[idx]
          matches += 1
        end
      end
    matches
  end

  def near_matches(another_code)
    #debugger
    matches = 0
    another_code_peg_freq = Hash.new(0)
    another_code.pegs.each do |peg|
      another_code_peg_freq[peg] += 1
    end

    self.pegs.each do |peg|
        if !another_code_peg_freq[peg].nil?
          if another_code_peg_freq[peg] > 0
            matches += 1
            another_code_peg_freq[peg] -= 1
          end
        end
    end

    exact = exact_matches(another_code)
    matches - exact
  end

  def ==(another_code)
    return false unless another_code.class == Code
    return false unless pegs.map(&:downcase) == another_code.pegs.map(&:downcase)
    true
  end
end


class Game
  attr_reader :secret_code

  def initialize(code = Code.random)
    @secret_code = code
  end

  def get_guess
    #debugger
    print "Enter your guess for the code. Valid colors are r, g, b, y, o, p. Example -> rbyg :"
    user_input = $stdin.gets.chomp
    Code.parse(user_input)
  end

  def display_matches(code)
    puts "exact matches: #{secret_code.exact_matches(code)}"
    puts "near matches: #{secret_code.near_matches(code)}"
  end

  def play

    guess = ""
    turns = 10
    until secret_code == guess
      puts "#{turns} turns remaining"
      guess = get_guess()
      turns -= 1
      display_matches(guess)
      if turns == 0
        puts "Out of turns"
        break
      end
    end

  end

end

if $PROGRAM_NAME == __FILE__
  secret_code = ARGV[0]
  game = secret_code.nil?? Game. new : Game.new(Code.parse(secret_code))
  game.play
end
