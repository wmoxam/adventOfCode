cals = []

cal = 0
$stdin.read.each_line do |s|
	if s.chomp == ""
		cals << cal
		cal = 0
	end

	cal += s.to_i
end

cals << cal

puts cals.sort[-3..-1].sum