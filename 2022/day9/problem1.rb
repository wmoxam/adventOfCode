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
			if head == tail
				head[:x] += 1
			elsif head[:y] == tail[:y]
				head[:x] += 1
				tail[:x] += 1
			elsif (head[:x] - tail[:x]).abs == 1 && (head[:y] - tail[:y]).abs == 1
				head[:x] += 1
				tail[:x] += 1
				tail[:y] = head[:y]
			else
				head[:x] += 1
				tail[:x] += 1
			end
		when 'L'
			if head == tail
				head[:x] -= 1
			elsif head[:y] == tail[:y]
				head[:x] -= 1
				tail[:x] -= 1
			elsif (head[:x] - tail[:x]).abs == 1 && (head[:y] - tail[:y]).abs == 1
				head[:x] -= 1
				tail[:x] -= 1
				tail[:y] = head[:y]
			else
				head[:x] -= 1
			end
		when 'D'
			if head == tail
				head[:y] += 1
			elsif head[:x] == tail[:x]
				head[:y] += 1
				tail[:y] += 1
			elsif (head[:x] - tail[:x]).abs == 1 && (head[:y] - tail[:y]).abs == 1
				head[:y] += 1
				tail[:y] += 1
				tail[:x] = head[:x]
			else
				head[:y] += 1
			end
		when 'U'
			if head == tail
				head[:y] -= 1
			elsif head[:x] == tail[:x]
				head[:y] -= 1
				tail[:y] -= 1
			elsif (head[:x] - tail[:x]).abs == 1 && (head[:y] - tail[:y]).abs == 1
				head[:y] -= 1
				tail[:y] -= 1
				tail[:x] = head[:x]
			else
				head[:y] -= 1
			end
		end

		puts "#{direction} : #{tail.inspect}"
	
		positions_visited << tail.dup
	end
end

puts positions_visited.uniq.inspect

puts positions_visited.uniq.length
