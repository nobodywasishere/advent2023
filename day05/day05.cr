input = File.read("input.txt")
# input = File.read("test1.txt")

input = input.split("\n\n").map { |i| i.split("\n") }

seeds = [] of Int64
seed_to_soil = {} of Range(Int64, Int64) => Range(Int64, Int64)
soil_to_fertilizer = {} of Range(Int64, Int64) => Range(Int64, Int64)
fertilizer_to_water = {} of Range(Int64, Int64) => Range(Int64, Int64)
water_to_light = {} of Range(Int64, Int64) => Range(Int64, Int64)
light_to_temperature = {} of Range(Int64, Int64) => Range(Int64, Int64)
temperature_to_humidity = {} of Range(Int64, Int64) => Range(Int64, Int64)
humidity_to_location = {} of Range(Int64, Int64) => Range(Int64, Int64)

def ranges_to_hash(dict, dest_range, source_range, range_length)
  dict[(source_range...source_range + range_length)] = (dest_range...dest_range + range_length)
end

input.each do |lines|
  case (type = lines[0])
  when /seeds/
    seeds = lines[0].split(":")[1].split(" ").select { |i| i != "" }.map(&.to_i64)
    puts "seeds: #{seeds}"
  when /seed-to-soil map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(seed_to_soil, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /soil-to-fertilizer map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(soil_to_fertilizer, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /fertilizer-to-water map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(fertilizer_to_water, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /water-to-light map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(water_to_light, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /light-to-temperature map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(light_to_temperature, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /temperature-to-humidity map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(temperature_to_humidity, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  when /humidity-to-location map/
    lines = lines.as Array(String)
    lines[1...].each do |line|
      data = line.match(/(\d+) (\d+) (\d+)/).try &.captures

      next if data.nil?
      dest_range, source_range, range_length = data
      next if dest_range.nil? || source_range.nil? || range_length.nil?
      ranges_to_hash(humidity_to_location, dest_range.to_i64, source_range.to_i64, range_length.to_i64)
    end
  else
    puts type.inspect
  end
end

def check_range_for_value(ranges, value)
  ranges.each do |in_range, out_range|
    return (value + out_range.begin - in_range.begin) if in_range.includes?(value)
  end

  return value
end

result = seeds.map do |seed|
  soil = check_range_for_value(seed_to_soil, seed)
  fertilizer = check_range_for_value(soil_to_fertilizer, soil)
  water = check_range_for_value(fertilizer_to_water, fertilizer)
  light = check_range_for_value(water_to_light, water)
  temperature = check_range_for_value(light_to_temperature, light)
  humidity = check_range_for_value(temperature_to_humidity, temperature)
  check_range_for_value(humidity_to_location, humidity)
end.min

puts "Part 1: #{result}"

result = seeds.in_groups_of(2).map do |seed_range|
  seed_range = seed_range.map(&.not_nil!)
  (seed_range[0]...seed_range[0] + seed_range[1]).map do |seed|
    soil = check_range_for_value(seed_to_soil, seed.not_nil!)
    fertilizer = check_range_for_value(soil_to_fertilizer, soil.not_nil!)
    water = check_range_for_value(fertilizer_to_water, fertilizer.not_nil!)
    light = check_range_for_value(water_to_light, water.not_nil!)
    temperature = check_range_for_value(light_to_temperature, light.not_nil!)
    humidity = check_range_for_value(temperature_to_humidity, temperature.not_nil!)
    check_range_for_value(humidity_to_location, humidity.not_nil!)
  end.min
end.min

puts "Part 2: #{result}"
