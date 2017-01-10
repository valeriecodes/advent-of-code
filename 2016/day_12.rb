class Decrypter
  attr_reader :registers
  def initialize(instructions, registers)
    @registers = registers
    @instructions = instructions
  end

  def apply_operator(i, operator, *args)
    case operator
    when 'cpy'
      @registers[args[1].to_sym] = value(args[0])
      i += 1
    when 'inc'
      @registers[args[0].to_sym] += 1
      i += 1
    when 'dec'
      @registers[args[0].to_sym] -= 1
      i += 1
    when 'jnz'
      value(args[0]) == 0 ?  i += 1 : i += value(args[1])
    end
    return i
  end

  def execute_instruction(i)
    instruction = @instructions[i]
    parsed_instruction = instruction.split(' ')
    return apply_operator(i, *parsed_instruction)
  end

  def do_instructions
    i = 0
    can_continue = true
    while i >= 0 && i < @instructions.size  do
      i = execute_instruction(i)
    end
  end

  def value(str)
    if str.match(/a|b|c|d/)
      @registers[str.to_sym]
    else
      str.to_i
    end
  end
end

# f = File.open('day_12_input.txt')
# input = f.read.split("\n")
# puts "Part 1"
# d = Decrypter.new(input, {a: 0, b: 0, c: 0, d: 0})
# d.do_instructions
# puts d.registers[:a]
# puts "Part 2"
# d2 = Decrypter.new(input, {a: 0, b: 0, c: 1, d: 0})
# d2.do_instructions
# puts d2.registers[:a]
