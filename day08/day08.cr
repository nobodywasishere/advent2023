input = File.read("input.txt")
# input = File.read("test1.txt")
# input = File.read("test2.txt")

steps, maps = input.split("\n\n")
steps = steps.split("")

dict = {} of String => Array(String)

maps.scan(/(\w+) = \((\w+), (\w+)\)/) do |line|
  src, left, right = line.captures
  next if src.nil? || left.nil? || right.nil?

  dict[src] = [left, right]
end

def count_steps(steps, dict)
  position = "AAA"
  step_count = 0_u64

  loop do
    step = steps[step_count % steps.size]
    position = dict[position][step == "R" ? 1 : 0]
    step_count += 1

    break if position == "ZZZ"
  end

  step_count
end

result = count_steps(steps, dict)

puts "Part 1: #{result}"

def count_steps_ghost(steps, dict, start)
  position = start
  step_count = 0_u64

  loop do
    step = steps[step_count % steps.size]
    position = dict[position][step == "R" ? 1 : 0]
    step_count += 1
    break if position.split("").last == "Z"
  end

  step_count
end

a_keys = dict.keys.select { |key| key.split("").last == "A" }

a_vals = a_keys.map { |key| count_steps_ghost(steps, dict, key) }

result = a_vals.reduce { |acc, i| acc.lcm(i) }

puts "Part 2: #{result}"
