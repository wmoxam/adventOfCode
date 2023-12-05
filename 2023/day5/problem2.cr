seeds = Array(NamedTuple(min: Int64, max: Int64)).new
seed_to_soil = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
soil_to_fert = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
fert_to_water = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
water_to_light = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
light_to_temp = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
temp_to_humid = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new
humid_to_loc = Array(NamedTuple(min: Int64, max: Int64, offset: Int64)).new

map = seed_to_soil

STDIN.each_line do |line|
  case line
  when /seeds:/
    ranges = line.split(/:/)[1].strip.split(/\s+/).map &.to_i64
    ranges.each_slice(2) do |slice|
      start, length = slice
      seeds << {min: start, max: start + length - 1}
    end
  when /seed-to-soil/
    map = seed_to_soil
  when /soil-to-fertilizer/
    map = soil_to_fert
  when /fertilizer-to-water/
    map = fert_to_water
  when /water-to-light/
    map = water_to_light
  when /light-to-temperature/
    map = light_to_temp
  when /temperature-to-humidity/
    map = temp_to_humid
  when /humidity-to-location/
    map = humid_to_loc
  when /^\s?$/
    next
  else
    dest_start, source_start, length = line.split(/\s/).map &.to_i64
    map << {min: source_start, max: source_start + length - 1, offset: dest_start - source_start}
  end
end

def calc(maps, result)
  maps.each do |map|
    possible_input = result - map[:offset]
    if possible_input >= map[:min] && possible_input <= map[:max]
      return possible_input
    end
  end

  result
end

location = 0.to_i64

while(true)
  location += 1
  humid = calc(humid_to_loc, location)
  temp = calc(temp_to_humid, humid)
  light = calc(light_to_temp, temp)
  water = calc(water_to_light, light)
  fert = calc(fert_to_water, water)
  soil = calc(soil_to_fert, fert)
  possible_seed = calc(seed_to_soil, soil)

  found = false

  seeds.each do |seed|
    if possible_seed >= seed[:min] && possible_seed <= seed[:max]
      found = true
    end
  end

  break if found
end

puts location