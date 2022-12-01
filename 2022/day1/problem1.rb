cals = []

cal = 0
$stdin.read.each_line do |s|
	if s.to_i == 0
		cals << cal
		cal = 0
	end

	cal += s.to_i
end

cals << cal

puts cals.sort.last