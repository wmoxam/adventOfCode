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

current_nodes = map.keys.select {|k| k[2] == 'A'}
i = 0
found = false

steps = Array.new(current_nodes.length, -1)

while true do

  directions.each do |direction|
  	i += 1

		index = case direction
  	when 'L'
  		0
  	when 'R'
  		1
  	end

  	current_nodes = current_nodes.map.with_index do |n, idx|
  		node = map[n][index]
  		if node[2] == "Z" && steps[idx] == -1
  			steps[idx] = i
  		end

  		node
  	end

  	if steps.all? {|s| s > -1}
  		found = true
  		break
  	end
  end

  break if found
end

puts steps.inspect

puts steps.reduce(1, :lcm)