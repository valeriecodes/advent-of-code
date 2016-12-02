class Present
  def initialize(length, width, height)
    @length = length
    @width = width
    @height = height
  end

  def smallest_side
    side_areas.min
  end

  def side_areas
    [@length * @width, @width * @height, @height * @length]
  end

  def surface_area
    side_areas.map{ |a| a * 2}.reduce(:+)
  end

  def wrapping_required
    surface_area + smallest_side
  end

  def bow_length
    @length * @width * @height
  end

  def ribbon_perimeter
    [@length + @width, @width + @height, @height + @length].min * 2
  end

  def ribbon_required
    ribbon_perimeter + bow_length
  end
end

f = File.open('day_2_input.txt')
input = f.read.split("\n")
presents = []
input.each do |item|
  presents << Present.new(*item.split('x').map(&:to_i))
end
puts "Part 1"
puts presents.map(&:wrapping_required).reduce(:+)
puts
puts "Part 2"
puts presents.map(&:ribbon_required).reduce(:+)
