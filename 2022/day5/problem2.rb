stacks = [[], [], [], [], [], [], [], [], []]
stacks_parsed = false

$stdin.read.each_line do |s|
	s.chomp!
	next if s.squeeze == " " || s.squeeze == ""

	unless stacks_parsed
		if s.match(/\[/).nil?
			stacks_parsed = true
			stacks.each {|s| s.reverse!}
			next
		end
		
		s.split('').each_with_index do |c,i|
			next if ((i + 1) % 4) == 0

			if ((i - 1) % 4) == 0
				if c != " " && c != nil
					stacks[((i - 1) / 4)] << c
				end
			end
		end

		next
	end

	match = s.match(/move (\d+) from (\d+) to (\d+)/)
	count, target, dest =	match[1].to_i, match[2].to_i - 1, match[3].to_i - 1
	stacks[dest].push(stacks[target].slice!(-count..-1)).flatten!
end

puts stacks.map {|s| s.pop }.compact.join