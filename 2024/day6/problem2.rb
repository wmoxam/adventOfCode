@map = []
$stdin.read.each_line do |line|
  @map << line.chomp
end

def change_direction!
  case @direction
  when :up
    @direction = :right
  when :right
    @direction = :down
  when :down
    @direction = :left
  when :left
    @direction = :up
  end
end

def will_change_direction?
  case @direction
  when :up
    @map[@position[:y] - 1] && ["#", "O"].include?(@map[@position[:y] - 1][@position[:x]])
  when :right
    ["#", "O"].include?(@map[@position[:y]][@position[:x] + 1])
  when :down
    @map[@position[:y] + 1] && ["#", "O"].include?(@map[@position[:y] + 1][@position[:x]])
  when :left
    ["#", "O"].include?(@map[@position[:y]][@position[:x] - 1])
  end
end

def off_map?
  @position[:x] >= @width ||
  @position[:x] < 0 ||
  @position[:y] >= @height ||
  @position[:y] < 0
end

def move!(changing_direction)
  change_direction! if changing_direction

  case @direction
  when :up
    @position[:y] -= 1
    @map[@position[:y]][@position[:x]] = "|" unless off_map?
  when :right
    @position[:x] += 1
    @map[@position[:y]][@position[:x]] = "-" unless off_map?
  when :down
    @position[:y] += 1
    @map[@position[:y]][@position[:x]] = "|" unless off_map?
  when :left
    @position[:x] -= 1
    @map[@position[:y]][@position[:x]] = "-" unless off_map?
  end
end

def vector_visited?
  @vectors.any? do |v|
    v[:x] == @position[:x] &&
      v[:y] == @position[:y] &&
      v[:direction] == @direction
  end
end

def run_map
  while true do
    changing_direction = will_change_direction?
    move!(changing_direction)
    return true if vector_visited?
    @vectors << {x: @position[:x], y: @position[:y], direction: @direction} if changing_direction
    return false if off_map?
  end
end

@position = {x: nil, y: nil}

@map.each_with_index do |positions, y|
  if x = positions.index('^')
    @position = {x: x, y: y}
    break
  end
end

@start_position = @position.clone
@direction = :up
@vectors = [{x: @position[:x], y: @position[:y], direction: @direction}]
@width = @map.first.length
@height = @map.length

original_map = @map.map(&:clone)
path_coords = []

while true do
  path_coords << [@position[:y], @position[:x]]
  move!(will_change_direction?)
  break if off_map?
end

positions = []

path_coords.uniq.each do |pair|
  y, x = pair
  next if original_map[x][y] == "#" || original_map[x][y] == "^"
  @map = original_map.map(&:clone)
  @position = @start_position.clone
  @direction = :up
  @vectors = [{x: @position[:x], y: @position[:y], direction: @direction}]
  @map[y][x] = "O"
  if run_map
    positions << [y, x]
    # puts "-----------------------"
    # puts @map
  end
end

puts positions.uniq.length