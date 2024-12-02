instructions = []

$stdin.read.each_line do |line|
	instruction, color = line.strip.split(/\(/)
	instructions << instruction
end

dug_coords = []
dug_coords << [0,0]
current_coords = [0, 0]

min_x = max_x = min_y = max_y = 0

instructions.each do |instruction|
	direction, distance = instruction.strip.split(/\s/)
	distance = distance.to_i

	distance.times do
		case direction
		when 'R'
			current_coords[0] += 1
		when 'U'
			current_coords[1] -= 1
		when 'L'
			current_coords[0] -= 1
		when 'D'
			current_coords[1] += 1
		end

		min_x = current_coords[0] if current_coords[0] < min_x
		max_x = current_coords[0] if current_coords[0] > max_x
		min_y = current_coords[1] if current_coords[1] < min_y
		max_y = current_coords[1] if current_coords[1] > max_y

		dug_coords << current_coords.dup
	end
end

puts "#{min_x} -> #{max_x}, #{min_y} -> #{max_y}"

puts dug_coords.uniq.inspect

# Fill

(min_x - 1).upto(max_x + 1) do |x|
	inside = false
	dug_previous_coord = false
	previous_coord_dug = false

	(min_y - 1).upto(max_y + 1) do |y|
		if dug_coords.include?([x, y]) && !inside
			inside = true
		elsif dug_coords.include?([x, y]) && inside
			inside = false
			dug_previous_coord = false
		elsif !dug_coords.include?([x, y]) && inside
			dug_coords << [x, y]
			dug_previous_coord = true
		end
	end
end

puts dug_coords.uniq.size

puts dug_coords.uniq.inspect