class Input
  attr_accessor :x1, :x2, :y1, :y2
  #
  # @param [<Type>] input String input in format x1,y1 -> x2,y2
  #
  def initialize(input)
    @input = input.strip
    parsed_inputs = @input.split(" -> ").map { |c| c.split(",").map(&:to_i) }

    @x1 = parsed_inputs[0][0]
    @x2 = parsed_inputs[1][0]
    @y1 = parsed_inputs[0][1]
    @y2 = parsed_inputs[1][1]
  end

  #
  # Iterator of coordinates that draw a line of the input
  #
  # @return [Iterator] iterator yields coordings of type Array: [x, y]
  #
  def coor_iter
    @coords = []
    if is_horizontal?
      ([@x1, @x2].min..[@x1, @x2].max).each { |x| @coords << [x, @y1] }
    elsif is_vertical?
      ([@y1, @y2].min..[@y1, @y2].max).each { |y| @coords << [@x1, y] }
    else
      diagnol_length = (@y2 - @y1).abs

      x_step = @x1 < @x2 ? 1 : -1
      y_step = @y1 < @y2 ? 1 : -1

      (0..diagnol_length).each do |offset|
        @coords << [@x1 + x_step * offset, @y1 + y_step * offset]
      end
    end

    @coords.each { |coord| yield coord }
  end

  #
  # @return [Boolean ]
  #
  def is_horizontal?
    @y1 == @y2
  end

  #
  # @return [Boolean ]
  #
  def is_vertical?
    @x1 == @x2
  end
end

class World
  attr_accessor :vents

  def initialize
    @vents = Hash.new(0)
  end

  #
  # Adds input to vent map
  #
  # @param [Input]
  #
  # @return [void]
  #
  def add_vent(input)
    input.coor_iter do |coord|
      @vents[coord] += 1
    end
  end
end

world = World.new
File.readlines("input").map do |line|
  input = Input.new(line)
  # uncomment below for part 1
  # next unless input.is_horizontal? || input.is_vertical?
  world.add_vent(input)
end

puts world.vents.values.count { |v| v > 1 }
