nums = []

pattern = "one|two|three|four|five|six|seven|eight|nine|\\d"
r = Regexp.new("[^#{pattern}]*(#{pattern}).*(#{pattern})[^#{pattern}]*")

$stdin.read.each_line do |s|
	matches = s.match(r) || s.match(/(#{pattern})/)

	digits = [matches[1], matches[2]].compact.map do |digit|
		case digit
		when "one"
			1
		when "two"
			2
		when "three"
			3
		when "four"
			4
		when "five"
			5
		when "six"
			6
		when "seven"
			7
		when "eight"
			8
		when "nine"
			9
		else
			digit.to_i
		end
  end

	nums << "#{digits[0]}#{digits[1] || digits[0]}".to_i
end

puts nums.sum