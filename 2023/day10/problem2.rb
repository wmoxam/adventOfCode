require 'set'
map = []
start_coords = []

$stdin.read.each_line.with_index do |line, y|
  positions = line.strip.split(//)
  start = positions.index('S')
  start_coords = [start, y] if start
  map << positions
end

class Navigator
  attr_accessor :map, :position, :direction, :step, :visited, :out_hand, :initial_direction, :mark_empty

  def initialize(map, position, direction)
    @map = map
    @position = position
    @direction = @initial_direction = direction
    @step = 1
    @visited = Set[position]
    @out_hand = nil
    @mark_empty = false
  end

  def blank_unvisited!
    map.each.with_index do |row, y|
      row.each.with_index do |c, x|
        map[y][x] = '.' unless visited.include?([x, y])
      end
    end
  end

  def flag_edges!
    empties = ['.', 'E']
    map.each.with_index do |row, y|
      row.each.with_index do |c, x|
        if empties.include?(c)
          map[y][x] = 'E'
        else
          break
        end
      end

      (row.size - 1).downto(0) do |x|
        if empties.include?(map[y][x])
          map[y][x] = 'E'
        else
          break
        end
      end
    end

    0.upto(row_size - 1) do |x|
      map.each.with_index do |row, y|
        if empties.include?(row[x])
          map[y][x] = 'E'
        else
          break
        end
      end

      (row_count - 1).downto(0).each do |y|
        if empties.include?(map[y][x])
          map[y][x] = 'E'
        else
          break
        end
      end
    end
  end

  def next_step!(check_out = false)
    return false unless can_proceed?

    if pipe == 'S' && step > 1
      puts 'Done navigation'
      return false
    else
      @position = next_coords
      @visited << position
      set_empties if mark_empty
      @direction = next_direction
      set_empties if mark_empty # in case direction changed
      @out_hand = calculate_out_hand if check_out && out_hand.nil?
      @step += 1
    end

    true
  end

  def pipe
    map[position[1]][position[0]]
  end

  def print_map
    map.each do |row|
      puts row.join
    end
  end

  def reset!
    @direction = initial_direction
    @step = 1
  end

  def total_enclosed_tiles
    a = map.collect do |row|
      row.select {|c| c == '.'}
    end.flatten.compact.size
  end

  private

  def row_count
    map.size
  end

  def row_size
    map.first.size
  end

  def calculate_out_hand
    empties = ['.', 'E']
    case direction
    when :west
      if map[0..(position[1] - 1)].map {|row| row[position[0]]}.all? { |c| empties.include?(c) }
        # path north
        :right
      elsif map[(position[1] + 1)..(row_count - 1)].map {|row| row[position[0]]}.all? { |c| empties.include?(c) }
        # path south
        :left
      end
    when :east
      if map[0..(position[1] - 1)].map {|row| row[position[0]]}.all? { |c| empties.include?(c) }
        # path north
        :left
      elsif map[(position[1] + 1)..(row_count - 1)].map {|row| row[position[0]]}.all? { |c| empties.include?(c) }
        # path south
        :right
      end
    when :north
      if map[position[1]][0..(position[0] - 1)].all? { |c| empties.include?(c) }
        # path west
        :left
      elsif map[position[1]][(position[0] + 1)..(map[0].size - 1)].all? { |c| empties.include?(c) }
        # path east
        :right
      end
    when :south
      if map[position[1]][0..(position[0] - 1)].all? { |c| empties.include?(c) }
        # path west
        :right
      elsif map[position[1]][(position[0] + 1)..(map[0].size - 1)].all? { |c| empties.include?(c) }
        # path east
        :left
      end
    end
  end

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
    return direction if ['S', '-', '|'].include?(pipe)

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

    raise "Unhandled pipe direction! pipe=#{pipe}, position=#{position}"
  end

  def set_empties
    empties = ['.', 'E']
    case direction
    when :west, :east
      if (direction == :west && out_hand == :right) || (direction == :east && out_hand == :left) # north
        (position[1] - 1).downto(0).each do |y|
          if empties.include?(map[y][position[0]])
            map[y][position[0]] = 'E'
          else
            break
          end
        end
      else # south
        (position[1] + 1).upto(row_count - 1).each do |y|
          if empties.include?(map[y][position[0]])
            map[y][position[0]] = 'E'
          else
            break
          end
        end
      end
    when :north, :south
      if (direction == :north && out_hand == :right) || (direction == :south && out_hand == :left) # east
        (position[0] + 1).upto(row_size - 1).each do |x|
          if empties.include?(map[position[1]][x])
            map[position[1]][x] = 'E'
          else
            break
          end
        end
      else # west
        (position[0] - 1).downto(0).each do |x|
          if empties.include?(map[position[1]][x])
            map[position[1]][x] = 'E'
          else
            break
          end
        end
      end
    end
  end

  def valid_pipe?(coords)
    next_pipe = map[coords[1]][coords[0]]
    return true if next_pipe == 'S'
    case direction
    when :west
      return true if ['-', 'L', 'F'].include?(next_pipe)
    when :east
      return true if ['-', 'J', '7'].include?(next_pipe)
    when :north
      return true if ['|', 'F', '7'].include?(next_pipe)
    when :south
      return true if ['|', 'J', 'L'].include?(next_pipe)
    end

    false
  end

  def within_bounds?(coords)
    return false if coords[0] < 0 || coords[1] < 0
    return false if coords[0] > row_size - 1
    return false if coords[1] > row_count - 1
    true
  end
end

navigators = [
  Navigator.new(map, start_coords, :west),
  Navigator.new(map, start_coords, :east),
  Navigator.new(map, start_coords, :south),
  Navigator.new(map, start_coords, :north),
]

farthest = 0

navigator = nil

while(true) do
  navigators = navigators.select do |nav|
    nav.next_step!
  end

  navigator = navigators.find {|n| n.pipe == 'S'}

  break if navigator
end

navigator.print_map

puts ""
navigator.blank_unvisited!
navigator.flag_edges!
navigator.print_map

navigator.reset!

while(true) do
  break unless navigator.next_step!(true)
  break unless navigator.out_hand.nil?
end

puts navigator.out_hand

navigator.reset!
navigator.mark_empty = true

while(true) do
  break unless navigator.next_step!
end

navigator.print_map

puts navigator.total_enclosed_tiles