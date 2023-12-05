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
		ranges = line.split(/:/)[1].strip.split(/\s+/).map &:to_i
		ranges.each_slice(2) do |start, length|
			seeds << {min: start, max: start + length - 1}
		end
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

def calc(maps, result)
	maps.each do |map|
		possible_input = result - map[:offset]
		if possible_input >= map[:min] && possible_input <= map[:max]
			return possible_input
		end
	end

	result
end

location = 0

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