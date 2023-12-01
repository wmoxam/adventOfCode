nums = []

$stdin.read.each_line do |s|
	digits = s.match(/^[^\d]*(\d).*(\d)[^\d]*$/) || s.match(/(\d)/)
	nums << "#{digits[1]}#{digits[2] || digits[1]}".to_i
end

puts nums.sum