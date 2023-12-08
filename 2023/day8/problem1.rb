directions = []
map = {}

$stdin.read.each_line do |line|
	if directions.empty?
		directions = line.strip.split(//)
		next
	end

	node, children = line.split(/=/)
	next if children.nil?

	node.strip!

	match = children.strip.match(/\((.+), (.+)\)/)

	map[node] = [match[1], match[2]]
end

current = 'AAA'
i = 0
found = false

while true do

  directions.each do |direction|
  	i += 1

  	case direction
  	when 'L'
  		current = map[current][0]
  	when 'R'
  		current = map[current][1]
  	end

  	if current == 'ZZZ'
  		found = true
  		break
  	end
  end

  break if found
end

puts i