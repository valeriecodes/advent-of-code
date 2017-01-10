def has_reversed_pattern?(str)
  (0...str.length - 3).each do |i|
    pattern = "#{str[i]}#{str[i + 1]}#{str[i + 1]}#{str[i]}"
    return true if str.match(/#{pattern}/) && str[i] != str[i + 1]
  end
  false
end

def is_compliant?(str)
  bracketed = str.scan(/\[[a-z]*\]/)
  bracketed.each do |sequence|
    return false if has_reversed_pattern?(sequence[1...-1])
    str = str.sub(sequence, '')
  end
  has_reversed_pattern?(str)
end

compliant_count = 0
puts "Part 1"
f = File.open('day_7_input.txt')
input = f.read.split("\n")
input.each do |line|
  compliant_count += 1 if is_compliant?(line)
end
puts compliant_count
