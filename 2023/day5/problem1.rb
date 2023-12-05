seeds = []
seed_to_soil = []
soil_to_fert = []
fert_to_water = []
water_to_light = []
light_to_temp = []
temp_to_humid = []
humid_to_loc = []

type = nil

$stdin.read.each_line do |line|
	case line
	when /seeds:/
		seeds = line.split(/:/)[1].strip.split(/\s+/).map &:to_i
	when /seed-to-soil/
		type = :seed_to_soil
	when /soil-to-fertilizer/
		type = :soil_to_fert
	when /fertilizer-to-water/
		type = :fert_to_water
	when /water-to-light/
		type = :water_to_light
	when /light-to-temperature/
		type = :light_to_temp
	when /temperature-to-humidity/
		type = :temp_to_humid
	when /humidity-to-location/
		type = :humid_to_loc
	when /^\s+$/
		next
	else
		dest_start, source_start, length = line.split(/\s/).map &:to_i
		eval(type.to_s) << {min: source_start, max: source_start + length - 1, offset: dest_start - source_start}
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