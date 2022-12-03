scorez = []

$scores = {
	'(' => 1,
	'[' => 2,
	'{' => 3,
	'<' => 4
}

$stdin.read.each_line do |line|
	line.chomp!

	corrupt = false
	stack = []
	line.each_char do |s|
		if s =~ /[\(\[\{\<]/
			stack.push(s)
		else
			last = stack.pop
			
			case last
				when '('
					if s != ')'
						corrupt = true
					end
				when '['
					if s != ']'
						corrupt = true 
					end
				when '{'
					if s != '}'
						corrupt = true
					end
				when '<'
					if s != '>'
						corrupt = true
					end
				end

			if corrupt
				break
			end 
		end
	end

	next if corrupt
	score = 0
	stack.reverse.each do |c|
		score = (score * 5) + $scores[c]
	end
	scorez << score
end

puts scorez.sort[scorez.length/2]