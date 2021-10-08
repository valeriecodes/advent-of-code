def fuel_required(mass)
  # Ruby does the rounding stuff for
  # us if we're working with integers
  mass/3 - 2
end

puts "Part 1"
f = File.open('day_1_input.txt')
input = f.read.split("\n")
puts input.map{ |module_mass| fuel_required(module_mass.to_i) }.sum

puts "Part 2"
initial_input = input.map{ |module_mass| fuel_required(module_mass.to_i) }
result = []
initial_input.each do |fuel_mass|
  while fuel_mass > 0
    result << fuel_mass
    fuel_mass = fuel_required(fuel_mass)
  end
end

puts result.sum
