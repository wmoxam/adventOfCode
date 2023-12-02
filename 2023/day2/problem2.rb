total = 0

$stdin.read.each_line do |line|
	game_s, sets_s = line.split(/:/)
	sets = sets_s.split(/;/)

	limits = {red: 0, green: 0, blue: 0}

	sets.each do |set_s|
		set_s.split(/,/).each do |item|
			num_s, color = item.strip.split(/\s+/)
			limit = limits[color.to_sym]
			num = num_s.to_i
			if num > limit
				limits[color.to_sym] = num
			end
		end
	end

	total += limits[:red] * limits[:green] * limits[:blue]
end

puts total