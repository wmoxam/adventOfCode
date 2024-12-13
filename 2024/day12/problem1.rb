@map = []

$stdin.read.each_line do |line|
  @map << line.chomp
end

@width = @map[0].length
@height = @map.length

class Region
  attr_accessor :plant, :coords

  def initialize(plant)
    @plant = plant
    @coords = []
  end

  def fences
    coords.inject(0) do |c, coord|
      y, x = coord
      c += 1 unless coords.include?([y, x - 1])
      c += 1 unless coords.include?([y, x + 1])
      c += 1 unless coords.include?([y - 1, x])
      c += 1 unless coords.include?([y + 1, x])
      c
    end
  end

  def plots
    coords.length
  end

  def to_s
    "#{plant} :  #{plots} * #{fences}"
  end
end

def seen_coords_include?(y, x)
  @regions.any? {|r| r.coords.include?([y,x]) }
end

def visit(visited, plant, y, x)
  return [] if x < 0 || x >= @width
  return [] if y < 0 || y >= @height
  return [] if visited.include?([y, x])
  return [] if @map[y][x] != plant

  visited << [y, x]

  return  [[y, x]] + visit(visited, plant, y - 1, x) +
          visit(visited, plant, y + 1, x) +
          visit(visited, plant, y, x - 1) +
          visit(visited, plant, y, x + 1)
end

@regions = []

@map.each_with_index do |line, y|
  line.each_char.with_index do |plant, x|
    next if seen_coords_include?(y, x)
    puts "y: #{y}, #{x}"
    region = Region.new(plant)
    region.coords = visit([], plant, y, x).uniq
    @regions << region
    puts region.to_s
  end
end

@regions.each do |r|
  puts "#{r.plant} :  #{r.plots} * #{r.fences}"
end

puts @regions.inject(0) { |c, region| c += region.plots * region.fences }
