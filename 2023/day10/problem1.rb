map = []
start_coords = []

$stdin.read.each_line.with_index do |line, y|
	positions = line.strip.split(//)
	start = positions.index('S')
	start_coords = [start, y] if start
	map << positions
end

class Navigator
	attr_accessor :map, :position, :direction, :step, :previous_position

	def initialize(map, position, previous_position, direction)
		@map = map
		@position = position
		@previous_position = previous_position
		@direction = direction
		@step = 1
	end

	def next_step!
		return false unless can_proceed?

		@previous_position = position
		@position = next_coords
		@direction = next_direction
		@step += 1
	end

	private

	def can_proceed?
		return false unless within_bounds?(next_coords)
		return false unless valid_pipe?(next_coords)

		true
	end

	def next_coords
		coords = position.dup
		case direction
		when :west
			coords[0] -= 1
		when :east
			coords[0] += 1
		when :north
			coords[1] -= 1
		when :south
			coords[1] += 1
		end

		coords
	end

	def next_direction
		pipe = map[position[1]][position[0]]

		return direction if ['-', '|'].include?(pipe)

		case pipe
		when 'L'
			return :north if direction == :west
			return :east if direction == :south
		when 'F'
			return :south if direction == :west
			return :east if direction == :north
		when 'J'
			return :north if direction == :east
			return :west if direction == :south
		when '7'
			return :south if direction == :east
			return :west if direction == :north
		end

		raise "Unhandled pipe direction!"
	end

	def valid_pipe?(coords)
		pipe = map[coords[1]][coords[0]]
		case direction
		when :west
			return true if ['-', 'L', 'F'].include?(pipe)
		when :east
			return true if ['-', 'J', '7'].include?(pipe)
		when :north
			return true if ['|', 'F', '7'].include?(pipe)
		when :south
			return true if ['|', 'J', 'L'].include?(pipe)
		end

		false
	end

	def within_bounds?(coords)
		return false if coords[0] < 0 || coords[1] < 0
		return false if coords[0] > map.first.size
		return false if coords[1] > map.size
		true
	end
end

navigators = [
	Navigator.new(map, start_coords, nil, :west),
	Navigator.new(map, start_coords, nil, :east),
	Navigator.new(map, start_coords, nil, :south),
	Navigator.new(map, start_coords, nil, :north),
]

farthest = 0

while(true) do
	navigators = navigators.select do |nav|
		nav.next_step!
	end

	navigators.combination(2).each do |pair|
		a, b = pair
		if a.position == b.position
			farthest = a.step - 1
		elsif a.previous_position == b.position || b.previous_position == a.position
			farthest = a.step - 2
		end
	end

	break if farthest > 0
end

puts farthest
