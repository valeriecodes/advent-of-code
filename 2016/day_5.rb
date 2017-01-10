require 'digest'

class DoorCode
  def initialize(door_id)
    @password = ''
    @door = door_id
  end

  def generate_password
    num = 0
    while @password.size < 8
      num += 1
      match = Digest::MD5.hexdigest("#{@door}#{num}").match(/^00000(.)/)
      @password += match[1] if match
    end
  end

  def fancy_generate_password
    new_password = [nil] * 8
    num = 0
    while new_password.include?(nil)
      num += 1
      match = Digest::MD5.hexdigest("#{@door}#{num}").match(/^00000(.)(.)/)
      if match
        position = match[1]
        character = match[2]
        next if !%w(0 1 2 3 4 5 6 7).include?(position)
        next if new_password[position.to_i]
        new_password[position.to_i] = character
      end
    end
    @password = new_password.join
  end

  def password
    @password
  end
end

puts "Part 1"
code = DoorCode.new('cxdnnyjw')
code.generate_password
puts code.password
puts "Part 2"
code.fancy_generate_password
puts code.password
