limits = {
	red: 12,
	green: 13,
	blue: 14
}

total = 0

$stdin.read.each_line do |line|
	game_s, sets_s = line.split(/:/)
	sets = sets_s.split(/;/)
	id = game_s.match(/\d+/)[0].to_i
	over_limit = false

	sets.each do |set_s|
		set_s.split(/,/).each do |item|
			num_s, color = item.strip.split(/\s+/)
			limit = limits[color.to_sym]
			over_limit = true if num_s.to_i > limit
		end
	end

	total += id unless over_limit
end

puts total