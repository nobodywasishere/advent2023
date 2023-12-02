input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

balls_max = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

result = input.map do |game|
  # puts "line: #{game.inspect}"
  data = game.match(/Game (\d+): (.*)/)
  next unless data

  level, rounds = data.captures
  rounds = rounds.split('; ')
  # puts "rounds: #{rounds.inspect}"

  balls = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }

  rounds.each do |round|
    colors = round.split(", ")

    colors.each do |color|
      count, hue = color.split(' ')

      balls[hue] = [count.to_i, balls[hue]].max
    end
  end

  # puts "balls: #{balls.inspect}"

  balls.all? { |k,v| balls_max[k] >= v } ? level.to_i : 0
end.sum

puts "Part 1: #{result}"

input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

balls_max = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

result = input.map do |game|
  # puts "line: #{game.inspect}"
  data = game.match(/Game (\d+): (.*)/)
  next unless data

  level, rounds = data.captures
  rounds = rounds.split('; ')
  # puts "rounds: #{rounds.inspect}"

  balls = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }

  rounds.each do |round|
    colors = round.split(", ")

    colors.each do |color|
      count, hue = color.split(' ')

      balls[hue] = [count.to_i, balls[hue]].max
    end
  end

  # puts "balls: #{balls.inspect}"
  # puts "product: #{balls.values.inject(:*)}"

  balls.values.inject(:*)
end.sum

puts "Part 2: #{result}"
