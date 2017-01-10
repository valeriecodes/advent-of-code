require 'set'

class Rover
  ORIENTATIONS = [:north, :east, :south, :west].freeze
  def initialize
    @x = 0
    @y = 0
    @orientation = :north
    @seen = Set.new(position)
    @repeat_location = nil
  end

  def turn_left
    @orientation = ORIENTATIONS[ORIENTATIONS.index(@orientation) - 1]
  end

  def turn_right
    @orientation = ORIENTATIONS[(ORIENTATIONS.index(@orientation) + 1) % ORIENTATIONS.length]
  end

  def move_forward(n)
    n.times do
      case @orientation
      when :north
        @y += 1
      when :south
        @y -= 1
      when :east
        @x += 1
      when :west
        @x -= 1
      end
      if @repeat_location.nil?
        if @seen.include?(position)
          @repeat_location = position
        else
          @seen.add(position)
        end
      end
    end
  end

  def position
    return [@x, @y]
  end

  def distance_from_start
    @x.abs + @y.abs
  end

  def execute_instruction(instruction)
    if instruction[0] == 'L'
      turn_left
    elsif instruction[0] == 'R'
      turn_right
    end
    move_forward(instruction[1..-1].to_i)
  end

  def repeat_location
    @repeat_location
  end
end

puts "Part 1"
puts "======"
input = "R1, L4, L5, L5, R2, R2, L1, L1, R2, L3, R4, R3, R2, L4, L2, R5, L1, R5, L5, L2, L3, L1, R1, R4, R5, L3, R2, L4, L5, R1, R2, L3, R3, L3, L1, L2, R5, R4, R5, L5, R1, L190, L3, L3, R3, R4, R47, L3, R5, R79, R5, R3, R1, L4, L3, L2, R194, L2, R1, L2, L2, R4, L5, L5, R1, R1, L1, L3, L2, R5, L3, L3, R4, R1, R5, L4, R3, R1, L1, L2, R4, R1, L2, R4, R4, L5, R3, L5, L3, R1, R1, L3, L1, L1, L3, L4, L1, L2, R1, L5, L3, R2, L5, L3, R5, R3, L4, L2, R2, R4, R4, L4, R5, L1, L3, R3, R4, R4, L5, R4, R2, L3, R4, R2, R1, R2, L4, L2, R2, L5, L5, L3, R5, L5, L1, R4, L1, R1, L1, R4, L5, L3, R4, R1, L3, R4, R1, L3, L1, R1, R2, L4, L2, R1, L5, L4, L5"
instructions = input.split(', ')
rover_one = Rover.new
instructions.each do |instruction|
  rover_one.execute_instruction(instruction)
end
puts "HQ is #{rover_one.distance_from_start} from the starting point"
puts
puts
puts "Part 2"
puts "======"
puts "The first location visited twice is #{rover_one.repeat_location}, it is #{rover_one.repeat_location.map(&:abs).reduce(:+)} blocks away"
