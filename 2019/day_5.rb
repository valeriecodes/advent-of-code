def intcode(input)
  arr = input.dup
  index = 0
  loop do
    opcode = arr[index]
    case opcode
    when 1
      p1, p2, output_index = arr[index + 1..index + 3]
      arr[output_index] = arr[p1] + arr[p2]
      index += 4
    when 2
      p1, p2, output_index = arr[index + 1..index + 3]
      arr[output_index] = arr[p1] * arr[p2]
      index += 4
    when 3

    when 99
      return arr[0]
    end
  end
end

def process_instruction(instruction, noun, verb)
  if instruction == 1
    noun + verb
  elsif
    noun * verb
  end
end

def run(noun, verb, input)
  input[1] = noun
  input[2] = verb
  intcode(input)
end

f = File.open('day_2_input.txt')
input = f.read.split(",").map(&:to_i)
puts "Part 1"
puts run(12, 2, input)
puts "Part 2"

(0..99).each do |noun|
  (0..99).each do |verb|
    if run(noun, verb, input) == 19690720
      puts 100 * noun + verb
      break
    end
  end
end
