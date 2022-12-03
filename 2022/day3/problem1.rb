score = 0

items = ''

def calc(c)
	if c == c.upcase
		c[0].ord - 38
	else
		c[0].ord - 96
	end
end

$stdin.read.each_line do |s|
	a = s[0..(s.length/2 - 1)]
	b = s[(s.length/2)..b]
	score += calc (a.split(//) & b.split(//)).first
end

puts score