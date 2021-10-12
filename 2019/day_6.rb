def orbit_map(input)
  orbits = {}
  input.each do |line|
    orbitee, orbiter = line.split(")")
    orbits[orbiter] = orbitee
  end
  orbits
end

def count_orbits(obj, orbit_map, counter)
  if orbit_map[obj]
    count_orbits(orbit_map[obj], orbit_map, counter + 1)
  else
    return counter
  end
end

f = File.open('day_6_input.txt')
input = f.read.split("\n")
all_objects = input.map{ |line| line.split(")")}.flatten.uniq
puts "Part 1"
running_counter = 0
orbit_map = orbit_map(input)
all_objects.each do |obj|
  running_counter += count_orbits(obj, orbit_map, 0)
end
puts running_counter
orbit_counts = Hash[ all_objects.map{ |obj| [obj, nil]} ]
puts "Part 2"
