def has_three_vowels?(str)
  letters = str.split('')
  vowels = letters.select{ |letter| 'aeiou'.include?(letter)}
  vowels.size >= 3
end

def has_double_letter?(str)
  (str.length - 1).times do |n|
    return true if str[n] == str[n + 1]
  end
  false
end

def no_naughty_strings?(str)
  return false if str.match(/ab/)
  return false if str.match(/cd/)
  return false if str.match(/pq/)
  return false if str.match(/xy/)
  true
end

def is_nice?(str)
  has_three_vowels?(str) && has_double_letter?(str) && no_naughty_strings?(str)
end

puts "Part 1"
f = File.open('day_5_input.txt')
input = f.read.split("\n")
nice_count = 0
input.each do |line|
  nice_count += 1 if is_nice?(line)
end
puts nice_count

def pair_appears_twice?(str)
  (str.length - 3).times do |n|
    pattern = "#{str[n]}#{str[n + 1]}"
    return true if str[n+2..-1].match(pattern)
  end
  false
end

def repeats_with_one_letter_between?(str)
  chars = str.split('').uniq
  chars.each do |char|
    return true if str.match(/#{char}.{1}#{char}/)
  end
  false
end

puts "Part 2"
new_nice_count = 0
input.each do |line|
  new_nice_count += 1 if repeats_with_one_letter_between?(line) && pair_appears_twice?(line)
end
puts new_nice_count
