universe = []

expanded_y = []

$stdin.read.each_line.with_index do |line, y|
	x = line.strip.split(//)
	if x.uniq == ['.']
		expanded_y << y
	end

	universe << x
end

expanded_x = []

0.upto(universe[0].size - 1).each do |i|
	col = universe.map {|row| row[i]}
	if col.uniq == ['.']
		expanded_x << i
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
	min_y = [source[1], dest[1]].min
	max_y = [source[1], dest[1]].max
	min_x = [source[0], dest[0]].min
	max_x = [source[0], dest[0]].max
	m_count = expanded_y.select {|y| y >= min_y && y <= max_y}.size
	m_count += expanded_x.select {|x| x >= min_x && x <= max_x}.size
	distances += (min_x - max_x).abs + (min_y - max_y).abs + ((m_count * 1000000 ) - m_count)
end

puts distances