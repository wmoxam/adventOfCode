stack = []
score = 0

$scores = {
	')' => 3,
	']' => 57,
	'}' => 1197,
	'>' => 25137
}

$stdin.read.each_line do |line|
	line.chomp!

	puts 'new line'
	line.each_char do |s|

		if s =~ /[\(\[\{\<]/
			stack.push(s)
		else
			last = stack.pop
			puts "#{last}, #{s}"
			corrupt = false
			case last
				when '('
					if s != ')'
						score += $scores[s]
						corrupt = true
					end
				when '['
					if s != ']'
						score += $scores[s]
						corrupt = true 
					end
				when '{'
					if s != '}'
						score += $scores[s]
						corrupt = true
					end
				when '<'
					if s != '>'
						score += $scores[s]
						corrupt = true
					end
				end

			if corrupt
				puts 'CORRUPT'
				break
			end 
		end
	end
end

puts score