input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n")

input = input.map do |i|
  i = i.gsub(/[^0-9]/, "")

  next 0 if i == ""

  (i[0].to_s + i[-1].to_s).to_i
end.sum

puts "Part 1: #{input}"

input = File.read("input.txt")
# input = File.read("test2.txt")

input = input.split("\n")

replace = {
  "one"   => "1",
  "two"   => "2",
  "three" => "3",
  "four"  => "4",
  "five"  => "5",
  "six"   => "6",
  "seven" => "7",
  "eight" => "8",
  "nine"  => "9",
}

input = input.map do |i|
  i.scan(/(#{replace.keys.join("|")}|[0-9])/).each do |scan|
    scan = scan[0]
    if scan.match(/[0-9]/)
      break
    end

    i = i.sub(/#{scan}/, replace[scan])
    break
  end

  i.reverse.scan(/(#{replace.keys.map { |i| i.reverse }.join("|")})/).each do |scan|
    scan = scan[0]
    if scan.match(/[0-9]/)
      break
    end

    i = i.reverse.sub(/#{scan}/, replace[scan.reverse]).reverse
    break
  end

  i = i.gsub(/[^0-9]/, "")

  next 0 if i == ""

  (i[0].to_s + i[-1].to_s).to_i
end.sum

puts "Part 2: #{input}"
