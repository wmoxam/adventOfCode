schematic = []

$stdin.read.each_line do |s|
	schematic << s.chomp.split(//)
end

$gear_symbol_coords = []

schematic.each.with_index do |row, y|
	row.each.with_index do |char, x|
		if char == "*"
			$gear_symbol_coords << "#{y},#{x}"
		end
	end
end

def adjacent_star_coords(x,y,current_number)
	return (0..(current_number.length - 1)).map do |offset|
		pos = x - offset

		[ "#{y-1},#{pos+1}",
			"#{y-1},#{pos}",
			"#{y-1},#{pos-1}",
			"#{y},#{pos+1}",
			"#{y},#{pos-1}",
			"#{y+1},#{pos+1}",
			"#{y+1},#{pos}",
			"#{y+1},#{pos-1}",
		].select {|coord| $gear_symbol_coords.include?(coord) }
	end.flatten.uniq
end

$potential_parts = {}

schematic.each.with_index do |row, y|
	current_number = ""
	row.each.with_index do |char, x|
		if char.match(/\d/)
			current_number << char
		else
			unless current_number.empty?
				star_coords = adjacent_star_coords(x-1, y, current_number)
				star_coords.each do |coord|
					$potential_parts[coord] ||= []
					$potential_parts[coord] << current_number
				end

				current_number = ""
			end
		end
	end

	unless current_number.empty?
		star_coords = adjacent_star_coords(row.length-1, y, current_number)
		star_coords.each do |coord|
			$potential_parts[coord] ||= []
			$potential_parts[coord] << current_number
		end
	end
end

sum = 0

$potential_parts.each_pair do |coord, nums|
	if nums.length == 2
		sum += nums[0].to_i * nums[1].to_i
	end
end

puts sum