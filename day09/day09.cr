input = File.read("input.txt")
# input = File.read("test1.txt")

sequences = input.split("\n")[0...-1].map { |i| i.split(" ").map(&.to_i) }

def predict_next(arr)
  diff = (0...arr.size - 1).map { |i| arr[i + 1] - arr[i] }

  last = if diff.any? { |i| i != 0 }
           predict_next(diff)
         else
           0
         end

  arr.last + last
end

result = sequences.sum do |sequence|
  predict_next(sequence)
end

puts "Part 1: #{result}"

def predict_prev(arr)
  diff = (0...arr.size - 1).map { |i| arr[i + 1] - arr[i] }

  first = if diff.any? { |i| i != 0 }
            predict_prev(diff)
          else
            0
          end

  arr.first - first
end

result = sequences.sum do |sequence|
  predict_prev(sequence)
end

puts "Part 2: #{result}"
