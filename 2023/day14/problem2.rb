require 'matrix'
world = []

$stdin.read.each_line do |line|
	world << line.strip.split(//)
end

shifted_world = []

0.upto(world.first.size - 1).each do |col_i|
	col = world.map {|row| row[col_i]}.join

	col_segments = col.split(/(?<=[#])/)
	new_col = col_segments.map do |segment|
		segment.split(//).sort.reverse.join
	end.join.split(//)

	shifted_world << new_col
end

total_load = 0
row_value = world.size

Matrix[*shifted_world].transpose.to_a.each do |row|
	row = row.flatten
	puts "#{row.join} #{row_value}"
	total_load += row.select {|s| s == "O"}.size * row_value
	row_value -= 1
end

puts total_load