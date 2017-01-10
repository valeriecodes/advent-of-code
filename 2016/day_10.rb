class Factory
  attr_reader :bots, :bins
  def initialize
    @bots = {}
    @bins = {}
  end

  def create_bot(num)
    @bots[num] = Bot.new(self)
  end

  def create_bin(num)
    @bins[num] = Bin.new(self)
  end

  def get_bot(key)
    @bots[key]
  end

  def get_bin(key)
    @bins[key]
  end

  def get(str)
    match = str.match(/^([a-z]+) ([0-9]+)$/)
    if match[1] == 'output'
      get_bin(match[2])
    elsif match[1] == 'bot'
      get_bot(match[2])
    end
  end

  def add(str)
    match = str.match(/^([a-z]+) ([0-9]+)$/)
    if match[1] == 'output'
      create_bin(match[2])
    elsif match[1] == 'bot'
      create_bot(match[2])
    end
  end
end

class Bot
  attr_reader :last_comparison, :chips
  def initialize(factory)
    @chips = []
    @factory = factory
    @instructions = []
    @last_comparison = nil
  end

  def take(chip)
    @chips << chip
    execute_instruction
  end

  def give(low, high)
    @last_comparison = @chips.sort
    low.take(@chips.min)
    high.take(@chips.max)
    @chips = []
  end

  def queue_instruction(line)
    @instructions << line
    execute_instruction
  end

  def execute_instruction
    if @chips.length == 2 && @instructions.length > 0
      instruction = @instructions.shift
      outputs = instruction.match(/low to ([a-z]+ [0-9]+) and high to ([a-z]+ [0-9]+)/)
      low = @factory.get(outputs[1])
      high = @factory.get(outputs[2])
      give(low, high)
    end
  end
end

class Bin
  attr_reader :chips
  def initialize(factory)
    @chips = []
    @factory = factory
  end

  def take(chip)
    @chips << chip
  end
end

f = File.open('day_10_input.txt')
full_input = f.read
factory = Factory.new
full_input.scan(/bot [0-9]+|output [0-9]+/).each do |item|
  factory.add(item)
end
input_lines = full_input.split("\n")
input_lines.each do |line|
  if match_data = line.match(/^value ([0-9]+) goes to bot ([0-9]+)/)
    bot = factory.get_bot(match_data[2])
    bot.take(match_data[1].to_i)
  else
    match_data = line.match(/^bot ([0-9]+) gives (.*)/)
    bot = factory.get_bot(match_data[1])
    bot.queue_instruction(match_data[2])
  end
end
puts "Part 1"
factory.bots.each do |key, bot|
  relevant_chips = [17, 61]
  puts "Bot #{key} is responsible for comparing #{relevant_chips.join(" and ")}" if bot.last_comparison == relevant_chips
end

puts "Part 2"
puts (factory.bins["0"].chips + factory.bins["1"].chips + factory.bins["2"].chips).reduce(:*)
