require 'colorize'

input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

sum = 0
# debug = []

def symbol_around(input, i, j)
  input = input.map{|l| l.split("")}

  (input.dig(i - 1, j) || "0")[/[^0-9\.]/] ||
  (input.dig(i + 1, j) || "0")[/[^0-9\.]/] ||
  (input.dig(i, j - 1) || "0")[/[^0-9\.]/] ||
  (input.dig(i, j + 1) || "0")[/[^0-9\.]/] ||
  (input.dig(i - 1, j + 1) || "0")[/[^0-9\.]/] ||
  (input.dig(i + 1, j + 1) || "0")[/[^0-9\.]/] ||
  (input.dig(i - 1, j - 1) || "0")[/[^0-9\.]/] ||
  (input.dig(i + 1, j - 1) || "0")[/[^0-9\.]/]
end

input.each_with_index do |line, i|
  # puts "line: #{line}"
  # debug_line = []
  last_idx = 0

  line.scan(/\d+/) do |match|
    start_idx = line.index(/\b#{match}\b/, last_idx)
    end_idx = start_idx + match.size

    # puts "#{match} (#{i}, #{start_idx}-#{end_idx})"

    # debug_line << line[last_idx...start_idx]
    last_idx = end_idx

    if (start_idx...end_idx).any? {|idx| symbol_around(input, i, idx)}
      # puts "Found symbol for #{match}"
      sum += match.to_i
      # debug_line << match.colorize(:green)
    else
      # debug_line << match.colorize(:red)
    end
  end

  # debug << debug_line.join + line[last_idx...line.size]

  # gets
end

result = sum

# puts debug.join("\n")

puts "Part 1: #{result}"

input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

def gear_around(input, i, j)
  input = input.map{|l| l.split("")}

  case
  when (input.dig(i - 1, j) || "0")[/\*/]
    [i - 1, j]
  when (input.dig(i + 1, j) || "0")[/\*/]
    [i + 1, j]
  when (input.dig(i, j - 1) || "0")[/\*/]
    [i, j - 1]
  when (input.dig(i, j + 1) || "0")[/\*/]
    [i, j + 1]
  when (input.dig(i - 1, j + 1) || "0")[/\*/]
    [i - 1, j + 1]
  when (input.dig(i + 1, j + 1) || "0")[/\*/]
    [i + 1, j + 1]
  when (input.dig(i - 1, j - 1) || "0")[/\*/]
    [i - 1, j - 1]
  when (input.dig(i + 1, j - 1) || "0")[/\*/]
    [i + 1, j - 1]
  else
    nil
  end
end

# debug = []
gears = {}

input.each_with_index do |line, i|
  # puts "line: #{line}"
  # debug_line = []
  last_idx = 0

  line.scan(/\d+/) do |match|
    start_idx = line.index(/\b#{match}\b/, last_idx)
    end_idx = start_idx + match.size

    # debug_line << line[last_idx...start_idx]
    last_idx = end_idx

    if (start_idx...end_idx).any? {|idx| gear_around(input, i, idx)}
      (start_idx...end_idx).each do |idx|
        gear_idx = gear_around(input, i, idx)
        next unless gear_idx

        gears[gear_idx] ||= []
        gears[gear_idx] << match.to_i unless gears[gear_idx].include?(match.to_i)
      end

      # debug_line << match.colorize(:green)
    else
      # debug_line << match.colorize(:red)
    end
  end

  # debug << debug_line.join + line[last_idx...line.size]

  # gets
end


# puts debug.join("\n")
# puts "gears: #{gears}"

result = gears.select { |k,v| v.size == 2 }.map{|k,v| v.inject(:*)}.sum

puts "Part 2: #{result}"
