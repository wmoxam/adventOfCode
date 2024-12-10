@map = []

$stdin.read.each_line do |line|
  @map << line.chomp.split(//).map(&:to_i)
end

@width = @map[0].length
@height = @map.length

def visit(elevation, x, y)
  return [] if x < 0 || x >= @width
  return [] if y < 0 || y >= @height
  return [] if @map[y][x] != elevation
  return [[x, y]] if elevation == 9

  next_elevation = elevation + 1

  return  visit(next_elevation, x - 1, y) +
          visit(next_elevation, x + 1, y) +
          visit(next_elevation, x, y - 1) +
          visit(next_elevation, x, y + 1)
end

def trailhead_score(x, y)
  visit(0, x, y).uniq.length
end

score = 0

@map.each_with_index do |row, y|
  row.each.with_index do |c, x|
    if c == 0
      s = trailhead_score(x, y)
      score += s
    end
  end
end

puts score