class Board
  attr_accessor :rows, :winner, :score
  def initialize(board)
    @rows = []
    @winner = false
    @score = 0
    board.each.with_index do |row, i|
      @rows[i] = row.split(" ").map(&:to_i)
    end
  end

  def add_num(num)
    # early exit if the board has already won
    return false if winner
    added = false
    rows.each do |row|
      added = row.find_index(num)
      if added
        row[added] = nil
        check_winner(num)
        break
      end
    end

    added
  end

  def check_winner(num)
    won = (rows + rows.transpose).any? do |row|
      row.all? { |r| r.nil? }
    end

    if won
      remaining = rows.map { |r| r.compact.sum }.sum
      self.score = num * remaining
      self.winner = true
    end

    won
  end
end

lines = File.readlines("input").map { |x| x.to_s.strip }
boards = []
winners = []

# Bingo Inputs are the first lines
bingo_inputs = lines[0].split(",").map(&:to_i)

# Starting with the third line, bingo boards are in sets of 6, with the
# 6th line being empty
remaining_inputs = lines[2..]

remaining_inputs.each_slice(6) do |slice|
  boards << Board.new(slice[0..-2])
end

bingo_inputs.each do |input|
  boards.each do |board|
    added = board.add_num(input)

    winners << board if added && board.winner
  end
end

puts winners.first.score
puts winners.last.score
