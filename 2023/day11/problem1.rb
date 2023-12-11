universe = []

$stdin.read.each_line do |line|
	x = line.strip.split(//)
	universe << x
	universe << x.dup if x.uniq == ['.']
end

blank_indexes = []

0.upto(universe[0].size - 1).each do |i|
	col = universe.map {|row| row[i]}
	if col.uniq == ['.']
		blank_indexes << i
	end
end

universe.each do |row|
	blank_indexes.reverse.each do |i|
		row.insert(i, '.')
	end
end

galaxy_coords = []

universe.each.with_index do |r, y|
	r.each_index do |x|
		galaxy_coords << [x, y] if r[x] == '#'
	end
end

distances = 0

pairs = galaxy_coords.combination(2)

pairs.each do |pair|
	source, dest = pair
	distances += (source[0] - dest[0]).abs + (source[1] - dest[1]).abs
end

puts distances