puts "Part 1"
f = File.open('day_2_input.txt')
input = f.read.split("\n")

def new_position(start_position, instruction)
  direction, amount = instruction.split(" ")
  amount = Integer(amount)
  case direction
  when "up"
    [start_position[0], start_position[1] - amount]
  when "down"
    [start_position[0], start_position[1] + amount]
  when "forward"
    [start_position[0] + amount, start_position[1]]
  else
    raise ArgumentError, "#{direction} is not a valid direction"
  end
end

i = 0
position = [0,0]
while i < input.length
  position = new_position(position, input[i])
  i +=  1
end

puts position[0] * position[1]

puts "Part 2"

def new_position_and_aim(start_position, start_aim, instruction)
  direction, amount = instruction.split(" ")
  amount = Integer(amount)
  case direction
  when "up"
    [start_position, start_aim - amount]
  when "down"
    [start_position, start_aim + amount]
  when "forward"
    [[start_position[0] + amount, start_position[1] + (start_aim * amount)], start_aim]
  else
    raise ArgumentError, "#{direction} is not a valid direction"
  end
end

position = [0,0]
aim = 0
i = 0
while i < input.length
  position, aim = new_position_and_aim(position, aim, input[i])
  i +=  1
end
puts position[0] * position[1]
