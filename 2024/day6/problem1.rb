@map = []
$stdin.read.each_line do |line|
  @map << line.chomp
end

@position = {x: nil, y: nil}
@direction = :up

def change_direction!
  case @direction
  when :up
    return unless @map[@position[:y] - 1] && @map[@position[:y] - 1][@position[:x]] == "#"
    @direction = :right
  when :right
    return unless @map[@position[:y]][@position[:x] + 1] == "#"
    @direction = :down
  when :down
    return unless @map[@position[:y] + 1] && @map[@position[:y] + 1][@position[:x]] == "#"
    @direction = :left
  when :left
    return unless @map[@position[:y]][@position[:x] - 1] == "#"
    @direction = :up
  end
end

def off_map?
  @position[:x] >= @map.first.length ||
  @position[:x] < 0 ||
  @position[:y] >= @map.length ||
  @position[:y] < 0
end

def move!
  change_direction!

  case @direction
  when :up
    @position[:y] -= 1
  when :right
    @position[:x] += 1
  when :down
    @position[:y] += 1
  when :left
    @position[:x] -= 1
  end
end

@map.each_with_index do |positions, y|
  if x = positions.index('^')
    @position = {x: x, y: y}
    break
  end
end

count = 1
while true do
  @map[@position[:y]][@position[:x]] = "X"
  move!
  break if off_map?
  count += 1 unless @map[@position[:y]][@position[:x]] == "X"
end

@map.each do |m|
  puts m
end

puts count