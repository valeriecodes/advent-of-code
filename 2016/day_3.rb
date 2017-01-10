class Triangle
  def self.is_possible?(side_lengths)
    return false if side_lengths.size != 3
    sorted_side_lengths =  side_lengths.sort
    return sorted_side_lengths[0] + sorted_side_lengths[1] > sorted_side_lengths[2]
  end
end

puts "Part 1"
f = File.open('day_3_input.txt')
input = f.read.split("\n")
dimensions_array = input.map{ |line| line.split().map(&:to_i)}
valid_count = 0
dimensions_array.each do |line|
  valid_count += 1 if Triangle.is_possible?(line)
end
puts valid_count

next_valid_count = 0
puts "Part 2"
dimensions_array.each_slice(3) do |rows|
  3.times do |n|
    next_valid_count += 1 if Triangle.is_possible?(rows.map{|row| row[n]})
  end
end
puts next_valid_count
