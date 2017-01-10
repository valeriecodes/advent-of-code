class WireSet
  def initialize
    @wires = Hash.new(0)
  end

  def assign(wire, value)
    @wires[wire] = value
  end

  def apply_logical_operation(operator, args)
    puts "operator: #{operator}"
    p args
    case operator
    when 'AND'
      args[0] & args[1]
    when 'OR'
      args[0] | args[1]
    when 'NOT'
      ~ args[0]
    when 'LSHIFT'
      args[0] << args[1]
    when 'RSHIFT'
      args[0] >> args[1]
    end
  end

  def execute_instruction(line)
    parsed = line.match(/^(.*) -> (.*)$/)
    puts parsed[1]
    if !parsed[1].match(/[A-Z]+/)
      assign(parsed[2], value(parsed[1]))
    else
      assign(parsed[2], apply_logical_operation(*split_logical_operation(parsed[1])))
    end
  end

  def split_logical_operation(logical_exp)
    parsed_expression = logical_exp.match(/^([a-z0-9]*) ?([A-Z]*) ([a-z0-9]*)$/)
    args = []
    arg1 = parsed_expression[1]
    arg2 = parsed_expression[3]
    operator = parsed_expression[2]
    puts operator
    if arg1 != ''
      args << value(arg1)
    end
    args << value(arg2)
    return operator, args
  end

  def value(str)
    if str.match(/[0-9]+/)
      str.to_i
    elsif str.length > 1
      str.split('').map{ |item| value(item) }.reduce(:*)
    else
      @wires[str]
    end
  end

  def print_set
    @wires.each do |key, value|
      puts "#{key}: #{value}"
    end
  end
end

puts "Part 1"
w = WireSet.new
f = File.open('day_7_input.txt')
input = f.read.split("\n")
input.each do |line|
  w.execute_instruction(line)
end
puts w.value('a')
