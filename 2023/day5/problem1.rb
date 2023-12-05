seeds = []
seed_to_soil = {}
soil_to_fert = {}
fert_to_water = {}
water_to_light = {}
light_to_temp = {}
temp_to_humid = {}
humid_to_loc = {}

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
		length.times do |i|
			eval(type.to_s)[source_start + i] = dest_start + i
		end
	end
end

locations = seeds.map do |seed|
	soil = seed_to_soil[seed] || seed
	fert = soil_to_fert[soil] || soil
	water = fert_to_water[fert] || fert
	light = water_to_light[water] || water
	temp = light_to_temp[light] || light
	humid = temp_to_humid[temp] || temp
	humid_to_loc[humid] || humid
end

puts locations.min