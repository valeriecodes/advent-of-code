def checksum(str)
  char_counter = {}
  str.split('').each do |char|
    if char.match(/[a-z]/)
      if char_counter[char]
        char_counter[char] += 1
      else
        char_counter[char] = 1
      end
    end
  end
  char_counter.sort_by{ |key, value| [-value, key] }.map(&:first).first(5).join
end

def valid_checksum?(input, checksum)
  checksum(input) == checksum
end

f = File.open('day_4_input.txt')
input = f.read.split("\n")
puts 'Part 1'
real_rooms = 0
input.each do |line|
  checksum = line.match(/\[(.*)\]/)[1]
  name = line.match(/^(.*)\-[0-9]+/)[1]
  sector = line.match(/\-([0-9]+)\[/)[1].to_i
  real_rooms += sector if valid_checksum?(name, checksum)
end
puts real_rooms

puts 'Part 2'
def decode(message, offset)
  alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('').freeze
  result = ''
  message.split('').each do |letter|
    result += ' ' and next if letter == '-'
    new_index = (alphabet.index(letter) + offset) % alphabet.size
    result += alphabet[new_index]
  end
  puts "#{offset}: #{result}"
end

room_hash = {}
input.each do |line|
  name = line.match(/^(.*)\-[0-9]+/)[1]
  sector = line.match(/\-([0-9]+)\[/)[1].to_i
  decode(name, sector)
end
