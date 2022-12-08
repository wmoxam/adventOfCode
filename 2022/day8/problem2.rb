grid = []

$stdin.read.each_line do |s|
	grid << s.chomp.split('').map(&:to_i)
end

distances = []

x_len = grid.first.length - 1
y_len = grid.length - 1

(0..(y_len)).each do |y|
	(0..(x_len)).each do |x|
		if x == 0 || y == 0 || x == x_len || y == y_len
			next
		end

		height = grid[y][x]

		left = (x-1).downto(0).inject(0){|sum, x1| 
			
			break sum + 1 if grid[y][x1] >= height
			sum + 1 
		}
		right =(x+1..(x_len)).inject(0){|sum, x1| 
			break sum + 1 if grid[y][x1] >= height 
			sum + 1
		}
		up = (y-1).downto(0).inject(0){|sum, y1| 
			break sum + 1 if grid[y1][x] >= height
			sum + 1
		}
		down = (y+1..(y_len)).inject(0){|sum, y1| 
			break sum + 1 if grid[y1][x] >= height
			sum + 1
		}

		distances << (left * right * up * down)
	end
end

puts distances.sort.last