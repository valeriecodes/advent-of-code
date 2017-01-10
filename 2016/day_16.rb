class Disk
  attr_reader :contents, :checksum

  def initialize(initial_state, size)
    @initial_state = initial_state
    @size = size
    calculate_contents
    calculate_checksum
  end

  def calculate_contents
    contents = @initial_state
    while contents.length < @size
      contents = self.class.unpack(contents)
      puts contents.size.to_s + '/' + @size.to_s
    end
    @contents = contents[0...@size]

  end

  def calculate_checksum
    puts "Checksum"
    checksum = self.class.simple_checksum(@contents, '')
    while checksum.length.even?
      checksum = self.class.simple_checksum(checksum, '')
      puts checksum.size.to_s
    end
    @checksum = checksum
  end

  def self.unpack(str)
    a = str
    b = str.reverse
    chars = b.split('').map{ |c| c == '0' ? '1' : '0' }
    b = chars.join('')
    a + '0' + b
  end

  def self.simple_checksum(str, result)
    return result if str.empty?
    case str[0...2]
    when '00' || '11'
      result += '1'
    when '01' || '10'
      result += '0'
    end
    simple_checksum(str[2..-1], result)
  end
end

puts "Test data"
test = Disk.new('10000', 20)
puts test.contents
puts test.checksum

puts "Part 1"
p1 = Disk.new('01000100010010111', 272)
puts p1.contents
puts p1.checksum
puts "Part 2"
p2 = Disk.new('01000100010010111', 35651584)
puts p2.checksum
