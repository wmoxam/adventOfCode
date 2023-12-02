positions_visited = []

head = {x: 0, y: 0}
tail = {x: 0, y: 0}

$stdin.read.each_line do |s|
	direction, distance = s.chomp.split(" ")
	distance = distance.to_i

	distance.times do
		case direction
		when 'R'
			head[:x] += 1

			if (head[:y] - tail[:y]).abs == 1 && head[:x] - tail[:x] > 1
				tail[:x] += 1
				tail[:y] = head[:y]
			elsif head[:x] - tail[:x] > 1
				tail[:x] += 1
			end
		when 'L'
			head[:x] -= 1

			if (head[:y] - tail[:y]).abs == 1 && tail[:x] - head[:x] > 1
				tail[:x] -= 1
				tail[:y] = head[:y]
			elsif tail[:x] - head[:x]  > 1
				tail[:x] -= 1
			end
		when 'D'
			head[:y] += 1

			if (head[:x] - tail[:x]).abs == 1 && head[:y] - tail[:y] > 1
				tail[:y] += 1
				tail[:x] = head[:x]
			elsif head[:y] - tail[:y] > 1
				tail[:y] += 1
			end
		when 'U'
			head[:y] -= 1

			if (head[:x] - tail[:x]).abs == 1 && tail[:y] - head[:y] > 1
				tail[:y] -= 1
				tail[:x] = head[:x]
			elsif tail[:y] - head[:y] > 1
				tail[:y] -= 1
			end
		end

		positions_visited << tail.dup
	end
end

puts positions_visited.uniq.length
