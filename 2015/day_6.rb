class LightGrid
  def initialize
    @grid = []
    1000.times do
      @grid << [false] * 1000
    end
  end

  def execute_instruction(line)
    parsed = line.match(/^(.+) ([0-9]*,[0-9]*) through ([0-9]*,[0-9]*)$/)
    instruction = parsed[1]
    top_corner = parsed[2].split(',').map(&:to_i)
    bottom_corner = parsed[3].split(',').map(&:to_i)
    (top_corner[0]..bottom_corner[0]).each do |i|
      (top_corner[1]..bottom_corner[1]).each do |j|
        case instruction
        when "toggle"
          @grid[j][i] = !@grid[j][i]
        when "turn on"
          @grid[j][i] = true
        when "turn off"
          @grid[j][i] = false
        end
      end
    end
  end

  def number_of_lights_on
    @grid.flatten.select{ |item| item == true }.size
  end
end

class FancyLightGrid
  def initialize
    @grid = []
    1000.times do
      @grid << [0] * 1000
    end
  end

  def execute_instruction(line)
    parsed = line.match(/^(.+) ([0-9]*,[0-9]*) through ([0-9]*,[0-9]*)$/)
    instruction = parsed[1]
    top_corner = parsed[2].split(',').map(&:to_i)
    bottom_corner = parsed[3].split(',').map(&:to_i)
    (top_corner[0]..bottom_corner[0]).each do |i|
      (top_corner[1]..bottom_corner[1]).each do |j|
        case instruction
        when "toggle"
          @grid[j][i] += 2
        when "turn on"
          @grid[j][i] += 1
        when "turn off"
          @grid[j][i] -= 1 if @grid[j][i] > 0
        end
      end
    end
  end

  def total_brightness
    @grid.flatten.reduce(:+)
  end
end


puts "Part 1"
lights = LightGrid.new
f = File.open('day_6_input.txt')
input = f.read.split("\n")
input.each do |line|
  lights.execute_instruction(line)
end
puts lights.number_of_lights_on
puts "Part 2"
more_lights = FancyLightGrid.new
input.each do |line|
  more_lights.execute_instruction(line)
end
puts more_lights.total_brightness
