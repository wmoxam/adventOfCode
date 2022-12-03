score = 0

def calc(c)
	if c == c.upcase
		c[0].ord - 38
	else
		c[0].ord - 96
	end
end

set = []
$stdin.read.each_line do |s|
	set = [] if set.length == 3

	set << s.split(//)

	if set.length == 3
		common = set[0] & set[1] & set[2]
		score += calc common.first
	end
end

puts score
