class KeyPad
  def initialize(values, initial_position)
    @values = values
    @column, @row = *initial_position
    @row_count = @values.length
    @column_count = @values.first.length
  end

  def value_at(row, column)
    @values[row][column]
  end

  def current_value
    value_at(@row, @column)
  end

  def values
    @values
  end

  def on_grid?(row, column)
    return false unless (row < @row_count && row >= 0) && (column < @column_count && column >= 0)
    !value_at(row, column).nil?
  end

  def next_number(instructions)
    instructions.split('').each do |command|
      case command
      when 'U'
        if on_grid?(@row - 1, @column)
          @row -= 1
        end
      when 'D'
        if on_grid?(@row + 1, @column)
          @row += 1
        end
      when 'L'
        if on_grid?(@row, @column - 1)
          @column -= 1
        end
      when 'R'
        if on_grid?(@row, @column + 1)
          @column += 1
        end
      end
    end
    return current_value
  end
end

f = File.open('day_2_input.txt')
input = f.read.split("\n")
puts "Part 1"
pad = KeyPad.new([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [1, 1])
code = []
input.each do |line|
  code << pad.next_number(line)
end
puts "The code is #{code.join}"

puts "Part 2"
fancy_pad = KeyPad.new([[nil, nil, 1, nil, nil], [nil, 2, 3, 4, nil], [5, 6, 7, 8, 9],  [nil, 'A', 'B', 'C', nil],  [nil, nil, 'D', nil, nil]], [0, 2])
next_code = []
input.each do |line|
  next_code << fancy_pad.next_number(line)
end
puts "The code is #{next_code.join}"
