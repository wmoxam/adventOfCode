map = {}

visual = []

width = 0
height = 0

$stdin.read.each_line.with_index do |line, y|
  visual << line
  width = line.length
  height += 1
  line.chomp.each_char.with_index do |c, x|
    next if c == '.'
    map[c] ||= []
    map[c] << [x,y]
  end
end

antinodes = []

map.each_pair do |freq, coords|
  coords.combination(2).to_a.each do |pair|
    a, b = pair

    antinodes << a
    antinodes << b
    delta1 = [a[0] - b[0], a[1] - b[1]]
    delta2 = [b[0] - a[0], b[1] - a[1]]

    i = 1
    while true
      candidate = [a[0] + (delta1[0] * i), a[1] + (delta1[1] * i)]
      break if candidate[0] < 0 ||
        candidate[0] >= width ||
        candidate[1] < 0 ||
        candidate[1] >= height
      antinodes << candidate
      i += 1
    end

    i = 1
    while true
      candidate = [b[0] + (delta2[0] * i), b[1] + (delta2[1] * i)]
      break if candidate[0] < 0 ||
        candidate[0] >= width ||
        candidate[1] < 0 ||
        candidate[1] >= height
      antinodes << candidate
      i += 1
    end
  end
end

antinodes.uniq.each do |coord|
  visual[coord[1]][coord[0]] = "#" if visual[coord[1]][coord[0]] == '.'
end

puts visual

puts antinodes.uniq.length
