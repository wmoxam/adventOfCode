positions_visited = []

knots = [
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0},
	{x: 0, y: 0}
]

$stdin.read.each_line do |s|
	direction, distance = s.chomp.split(" ")
	distance = distance.to_i

	distance.times do
		case direction
		when 'R'
			knots[0][:x] += 1
		when 'L'
			knots[0][:x] -= 1
		when 'D'
			knots[0][:y] += 1
		when 'U'
			knots[0][:y] -= 1
		end

		(0..8).each do |i|
			head = knots[i]
			tail = knots[i + 1]
		
			if (head[:y] - tail[:y]).abs > 1 && (head[:x] - tail[:x]).abs == 1
				if(head[:y] - tail[:y] > 0)
					tail[:y] = head[:y] - 1
				else
					tail[:y] = head[:y] + 1
				end
				tail[:x] = head[:x]
			elsif (head[:x] - tail[:x]).abs > 1 && (head[:y] - tail[:y]).abs == 1
				if(head[:x] - tail[:x] > 0)
					tail[:x] = head[:x] - 1
				else
					tail[:x] = head[:x] + 1
				end
				tail[:y] = head[:y]
			elsif (head[:x] - tail[:x]) < -1
				tail[:x] = head[:x] + 1
			elsif (head[:x] - tail[:x]) > 1
				tail[:x] = head[:x] - 1
			elsif (head[:y] - tail[:y]) < -1
				tail[:y] = head[:y] + 1
			elsif (head[:y] - tail[:y]) > 1
				tail[:y] = head[:y] - 1
			end
		end

		positions_visited << knots.last.dup
	end
end

puts positions_visited.uniq.inspect
puts positions_visited.uniq.length