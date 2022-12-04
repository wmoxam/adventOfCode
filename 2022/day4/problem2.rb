score = 0

$stdin.read.each_line do |s|
	a,b = s.split(/,/)
	a1,a2 = a.split(/-/).map(&:to_i)
	b1,b2 = b.split(/-/).map(&:to_i)
	range1 = a1..a2
	range2 = b1..b2

	if range1.to_a.any? {|c| range2.include?(c) }
		score += 1 
	elsif range2.to_a.any? {|c| range1.include?(c) }
		score += 1
	end 
end

puts score