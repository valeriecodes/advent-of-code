def eligible_password_count_p1(low, high)
  count = 0
  (low..high).each do |n|
    if is_eligible_p1?(n)
      count += 1
    end
  end
  return count
end

def eligible_password_count_p2(low, high)
  count = 0
  (low..high).each do |n|
    if is_eligible_p2?(n)
      count += 1
    end
  end
  return count
end

def is_eligible_p2?(password)
  password_array = password.to_s.split("")
  two_but_not_three_adjacent_digits?(password.to_s) && all_increasing?(password_array)
end

def is_eligible_p1?(password)
  password_array = password.to_s.split("")
  two_adjacent_digits?(password_array) && all_increasing?(password_array)
end

def two_but_not_three_adjacent_digits?(password)
  characters = password.split("").uniq
  characters.each do |c|
    if  /(?:\A|[^#{c}])#{c}{2}(?:\Z|[^#{c}])/.match(password)
      return true
    end
  end
  return false
end

def two_adjacent_digits?(character_array)
   character_array.length.times do |i|
     if i == character_array.length - 1
       return false
     elsif character_array[i + 1] == character_array[i]
       return true
     end
   end
end

def all_increasing?(character_array)
  numbers = character_array.map(&:to_i)
  numbers.length.times do |i|
    if i == numbers.length - 1
      return true
    elsif numbers[i + 1] < numbers[i]
      return false
    end
  end
end

puts "Part 1"
puts eligible_password_count_p1(178416,676461)
puts "Part 2"
puts eligible_password_count_p2(178416,676461)
