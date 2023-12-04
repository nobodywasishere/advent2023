input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

result = input.map do |line|
  card_and_winners, numbers = line.split("|")
  card, winners = card_and_winners.split(":")
  # next 0 if card == nil || winners == nil || numbers == nil

  numbers = numbers.strip.split(" ")
  winners = winners.strip.split(" ")

  matches = numbers.size - (numbers - winners).size - 1

  matches >= 0 ? 2**matches : 0
end.sum

puts "Part 1: #{result}"

input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

cards = {}

input.each do |line|
  card_and_winners, numbers = line.split("|")
  card, winners = card_and_winners.split(":")
  # next 0 if card == nil || winners == nil || numbers == nil

  card = card.split(" ")[1].to_i
  cards[card] ||= 0
  cards[card] += 1

  # puts "Card #{card} (#{cards[card]})"

  numbers = numbers.strip.split(" ")
  winners = winners.strip.split(" ")

  matches = numbers.size - (numbers - winners).size
  matches = 0 if matches < 0

  # puts "Points: #{matches}"

  matches.times do |i|
    next if i > input.size
    # puts "Adding to #{card + i + 1}"
    cards[card + i + 1] ||= 0
    cards[card + i + 1] += cards[card]
  end

  # puts "Cards: #{cards}"
end

result = cards.values.sum

puts "Part 2: #{result}"
