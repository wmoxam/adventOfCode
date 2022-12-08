grid = []

$stdin.read.each_line do |s|
	grid << s.chomp.split('').map(&:to_i)
end

visible = 0

x_len = grid.first.length - 1
y_len = grid.length - 1

(0..(y_len)).each do |y|
	(0..(x_len)).each do |x|
		if x == 0 || y == 0 || x == x_len || y == y_len
			visible += 1
			next
		end

		height = grid[y][x]

		if (
			((0..(x-1)).all?{|x1| grid[y][x1] < height}) ||
			((x+1..(x_len)).all?{|x1| grid[y][x1] < height}) ||
			((0..(y-1)).all?{|y1| grid[y1][x] < height}) ||
			((y+1..(y_len)).all?{|y1| grid[y1][x] < height})
		)
			visible += 1
		end
	end
end

puts visible