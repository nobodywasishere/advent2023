input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")[0...-1].map { |i| i.split(" ") }

Cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

class Hand
  include Comparable(self)

  enum HandType
    HighCard
    OnePair
    TwoPair
    ThreeKind
    FullHouse
    FourKind
    FiveKind
  end

  getter hand : String
  getter type : HandType
  getter bid : Int32
  getter? joker : Bool

  def initialize(@hand, @bid, @joker = false)
    @type = calc_hand_type(@hand)
  end

  def calc_hand_type(hand : String) : HandType
    if joker?
      case
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 5 }
        HandType::FiveKind
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 4 }
        HandType::FourKind
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 3 && (Cards - [card, "J"]).any? { |other_card| hand.count(other_card) == 2 } }
        HandType::FullHouse
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 3 }
        HandType::ThreeKind
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 2 && (Cards - [card, "J"]).any? { |other_card| hand.count(other_card) == 2 } }
        HandType::TwoPair
      when (Cards - ["J"]).any? { |card| (hand.count(card) + hand.count("J")) == 2 }
        HandType::OnePair
      when hand.split("").uniq.size == 5 && hand.count("J") == 0
        HandType::HighCard
      else
        raise "Unknown type for #{hand}"
      end
    else
      case
      when Cards.any? { |card| hand.count(card) == 5 }
        HandType::FiveKind
      when Cards.any? { |card| hand.count(card) == 4 }
        HandType::FourKind
      when Cards.any? { |card| hand.count(card) == 3 } && Cards.any? { |card| hand.count(card) == 2 }
        HandType::FullHouse
      when Cards.any? { |card| hand.count(card) == 3 }
        HandType::ThreeKind
      when Cards.any? { |card| hand.count(card) == 2 && (Cards - [card, "J"]).any? { |other_card| hand.count(other_card) == 2 } }
        HandType::TwoPair
      when Cards.any? { |card| hand.count(card) == 2 }
        HandType::OnePair
      when hand.split("").uniq.size == 5
        HandType::HighCard
      else
        raise "Unknown type for #{hand}"
      end
    end
  end

  def <=>(other : Hand)
    if type > other.type
      return 1
    elsif type < other.type
      return -1
    else
      hand.split("").each_with_index do |ch, idx|
        other_ch = other.hand.split("")[idx]

        card_idx = (joker? && ch == "J") ? Cards.size : Cards.index(ch)
        other_idx = (joker? && other_ch == "J") ? Cards.size : Cards.index(other.hand.split("")[idx])

        if card_idx.nil? || other_idx.nil?
          raise "One hand too long: #{self}, #{other}"
        end

        if card_idx < other_idx
          return 1
        elsif card_idx > other_idx
          return -1
        else
          next
        end
      end

      puts "Hands the same: #{self} == #{other}"
      return 0
    end

    raise "Shouldn't reach here"
  end

  def to_s(io : IO)
    io << "#{hand} (type: #{type.to_s.rjust(9)}, bid: #{bid.to_s.rjust(3)})"
  end
end

hands = input.map { |(hand, bid)| Hand.new(hand, bid.to_i) }

result = hands.sort.map_with_index do |hand, idx|
  # puts "#{hand}, #{idx + 1}"
  hand.bid * (idx + 1)
end.sum

puts "Part 1: #{result}"

hands = input.map { |(hand, bid)| Hand.new(hand, bid.to_i, true) }

result = hands.sort.map_with_index do |hand, idx|
  # puts "#{hand}, #{idx + 1}"
  hand.bid * (idx + 1)
end.sum

puts "Part 2: #{result}"
