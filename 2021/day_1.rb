puts "Part 1"
f = File.open('day_1_input.txt')
input = f.read.split("\n").map(&:to_i)

increases = 0
(1...input.length).each do |index|
  if input[index - 1] < input[index]
    increases += 1
  end
end

puts increases

puts "Part 2"
window_increases = 0
(3...input.length).each do |index|
  window1 = input[index - 2] + input[index - 1] + input[index - 3]
  window2 = input[index - 2] + input[index - 1] + input[index]
  if window1 < window2
    window_increases += 1
  end
end

puts window_increases
