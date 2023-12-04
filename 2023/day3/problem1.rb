schematic = []

$stdin.read.each_line do |s|
	schematic << s.chomp.split(//)
end

$symbol_coords = []

schematic.each.with_index do |row, y|
	row.each.with_index do |char, x|
		if !char.match(/\d/) && char != "."
			$symbol_coords << "#{y},#{x}"
		end
	end
end

def is_part?(x,y,current_number)
	(0..(current_number.length - 1)).each do |offset|
		pos = x - offset

		return true if [
			"#{y-1},#{pos+1}",
			"#{y-1},#{pos}",
			"#{y-1},#{pos-1}",
			"#{y},#{pos+1}",
			"#{y},#{pos-1}",
			"#{y+1},#{pos+1}",
			"#{y+1},#{pos}",
			"#{y+1},#{pos-1}",
		].any? {|coord| $symbol_coords.include?(coord) }
	end

	false
end

part_numbers = []

schematic.each.with_index do |row, y|
	current_number = ""
	row.each.with_index do |char, x|
		if char.match(/\d/)
			current_number << char
		else
			unless current_number.empty?
				part_numbers << current_number.to_i if is_part?(x - 1, y, current_number)

				current_number = ""
			end
		end
	end

	unless current_number.empty?
		part_numbers << current_number.to_i if is_part?(row.length - 1, y, current_number)
	end
end

puts part_numbers.sum