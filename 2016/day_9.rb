class Message
  def initialize(compressed_str)
    @compressed = compressed_str
  end

  def decompressed
    self.class.decompressed(@compressed)
  end

  def recursive_decompressed
    self.class.recursive_decompressed(@compressed)
  end

  def recursive_decompressed_counter
    self.class.recursive_decompressed_counter(@compressed)
  end

  def self.recursive_decompressed(str)
    marker = str.match(/\(([0-9]+)x([0-9]+)\)/)
    if marker
      pre_marker, post_marker = str.split(marker[0], 2)
      substring_length =  marker[1].to_i
      repetitions = marker[2].to_i
      post_marker = repeat_characters(post_marker, repetitions, substring_length)
      puts "pre: #{pre_marker}"
      puts "post: #{post_marker}"
      pre_marker + recursive_decompressed(post_marker)
    else
      str
    end
  end

  def self.recursive_decompressed_counter(str)
    marker = str.match(/\(([0-9]+)x([0-9]+)\)/)
    if marker
      pre_marker, post_marker = str.split(marker[0], 2)
      substring_length =  marker[1].to_i
      repetitions = marker[2].to_i
      substring = post_marker[0...substring_length]
      remainder = post_marker[substring_length..-1]
      pre_marker.length + (repetitions * recursive_decompressed_counter(substring)) + recursive_decompressed_counter(remainder)
    else
      str.length
    end
  end

  def self.decompressed(str)
    result = ''
    while marker = str.match(/\(([0-9]+)x([0-9]+)\)/)
      substring_length =  marker[1].to_i
      repetitions = marker[2].to_i
      result += str[0...str.index(marker[0])]
      str = str[(str.index(marker[0]) + marker[0].length)..-1]
      result += (str[0...substring_length] * repetitions)
      str = str[substring_length..-1]
    end
    result += str
    result
  end

  private
  def self.repeat_characters(str, repetitions, length)
    (str[0...length] * repetitions) + str[length..-1]
  end
end

puts "Part 1"
f = File.open('day_9_input.txt')
compressed_input = f.read.gsub(/\s+/, "")
m = Message.new(compressed_input)
puts m.decompressed.size
puts "Part 2"
puts m.recursive_decompressed_counter
