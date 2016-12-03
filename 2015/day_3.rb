require 'set'

class Rover
  def initialize
    @x = 0
    @y = 0
    @seen = Set.new
    @seen.add(position)
  end

  def move(char)
    case char
    when '^'
      @y += 1
    when 'v'
      @y -= 1
    when '>'
      @x += 1
    when '<'
      @x -= 1
    end
    @seen.add(position)
  end

  def position
    [@x, @y]
  end

  def houses_visited
    @seen.size
  end

  def seen
    @seen
  end
end

f = File.open('day_3_input.txt')
input = f.read.split('')
r = Rover.new
input.each do |instruction|
  r.move(instruction)
end
puts "Part 1"
puts r.houses_visited
puts
puts "Part 2"
santa = Rover.new
robo_santa = Rover.new
input.each_slice(2) do |moves|
  santa.move(moves[0])
  robo_santa.move(moves[1])
end
puts santa.seen.merge(robo_santa.seen).size
