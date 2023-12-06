input = File.read("input.txt")
# input = File.read("test1.txt")

times, distances = input.split("\n")[0...-1].map { |i| i.split(/[ ]+/)[1..].map(&.to_i) }

result = times.map_with_index do |time, idx|
  distance = distances[idx]

  wins = (0..time).map do |hold_time|
    run_time = time - hold_time
    # puts "hold: #{hold_time}"

    dist = run_time * hold_time
    # puts dist

    dist
  end.select do |run|
    run > distance
  end.size
end.product

puts "Part 1: #{result}"

input = File.read("input.txt")
# input = File.read("test1.txt")

time, distance = input.split("\n")[0...-1].map { |i| i.split(":")[1].gsub(" ", "").to_i64 }

result = (0..time).map do |hold_time|
  run_time = time - hold_time
  # puts "hold: #{hold_time}"

  dist = run_time * hold_time
  # puts dist

  dist
end.select do |run|
  run > distance
end.size

puts "Part 2: #{result}"
