class Board
    attr_accessor :rows, :winner, :score

    #
    # @param [Array<String>] board representation of bingo board, as an array of row strings
    #
    def initialize(board)
      @rows = []
      @winner = false
      @score = 0
      board.each.with_index do |row, i|
        @rows[i] = row.split(' ').map(&:to_i)
      end
    end

    #
    # Marks number on bingo board, if found. Checks if board is a winner if nubmer added
    # Winner boards do not get numbers adde
    #
    # @param [Integer] num bingo number board called
    #
    # @return [Boolean] whether or not number was added to board
    #
    def add_num(num)
        # early exit if the board has already won
        return false if self.winner
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

    #
    # Checks if the board has bingo, ignoring diagnol conditions
    # This persists the score of the board if the board has won
    #
    # @param [Integer] num bingo number just added to board
    #
    # @return [Boolean] if this number resulted in a winning board
    #
    def check_winner(num)
        won = (rows + rows.transpose).any? do |row|
           row.all?{|r| r.nil?}
        end
        
        if won
            remaining = rows.map {|r| r.compact.sum }.sum
            self.score = num * remaining
            self.winner = true
        end

        won
    end
end


lines = File.readlines('input').map{|x| x.to_s.strip}
boards = []
winners = []

# Bingo Inputs are the first lines
bingo_inputs = lines[0].split(',').map(&:to_i)


# Starting with the third line, bingo boards are in sets of 6, with the 
# 6th line being empty
remaining_inputs = lines[2..]

remaining_inputs.each_slice(6) do |slice|
    boards << Board.new(slice[0..-2])
end


bingo_inputs.each.with_index do |input|
    boards.each.with_index do |board|
        added = board.add_num(input)
        
        winners << board if added && board.winner
    end
end

puts winners.first.score
puts winners.last.score
