seeds = [] of Int64
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
    seeds = line.split(/:/)[1].strip.split(/\s+/).map &.to_i64
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
    # skip
  else
    dest_start, source_start, length = line.split(/\s/).map &.to_i64
    map << {min: source_start, max: source_start + length - 1, offset: dest_start - source_start}
  end
end

def calc(maps, input)
  maps.each do |map|
    if input >= map[:min] && input <= map[:max]
      return input + map[:offset]
    end
  end

  input
end

locations = seeds.map do |seed|
  soil = calc(seed_to_soil, seed)
  fert = calc(soil_to_fert, soil)
  water = calc(fert_to_water, fert)
  light = calc(water_to_light, water)
  temp = calc(light_to_temp, light)
  humid = calc(temp_to_humid, temp)
  calc(humid_to_loc, humid)
end

puts locations.min