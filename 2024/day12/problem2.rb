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

  def fences # sides
    sides = 0

    y_plots.each do |y|
      x_left = []
      x_right = []
      coords.select {|c| c[0] == y }.each do |coord|
        x = coord[1]
        x_left << x unless coords.include?([y, x - 1])
        x_right << x unless coords.include?([y, x + 1])
      end

      sides += x_left.uniq.sort.slice_when { |a, b| b != a + 1 }.to_a.size
      sides += x_right.uniq.sort.slice_when { |a, b| b != a + 1 }.to_a.size
    end

    x_plots.each do |x|
      y_up = []
      y_down = []

      coords.select {|c| c[1] == x }.each do |coord|
        y = coord[0]
        y_up << y unless coords.include?([y - 1, x])
        y_down << y unless coords.include?([y + 1, x])
      end

      sides += y_up.uniq.sort.slice_when { |a, b| b != a + 1 }.to_a.size
      sides += y_down.uniq.sort.slice_when { |a, b| b != a + 1 }.to_a.size
    end

    sides
  end

  def y_plots
    coords.map {|c| c[0] }.uniq
  end

  def x_plots
    coords.map {|c| c[1] }.uniq
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
    region = Region.new(plant)
    region.coords = visit([], plant, y, x).uniq
    @regions << region
    puts region.to_s
    exit
  end
end

# @regions.each do |r|
#   puts "#{r.plant} :  #{r.plots} * #{r.fences}"
# end

puts @regions.inject(0) { |c, region| c += region.plots * region.fences }
