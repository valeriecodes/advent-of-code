require 'digest'

def secret_key(str, pattern)
  match = false
  num = 0
  while match == false
    num += 1
    match =  true if Digest::MD5.hexdigest("#{str}#{num}").match(pattern)
  end
  return num
end

puts "Part 1"
puts secret_key('bgvyzdsv', /^00000/)
puts "Part 2"
puts secret_key('bgvyzdsv', /^000000/)
