left = []
right = []

$stdin.read.each_line do |line|
  all,l,r = line.split(/(\d+)\s+(\d+)/)
  left << l.to_i
  right << r.to_i
end

left.sort!
right.sort!

score = 0

left.each do |l|
  score += l * right.select {|r| r == l }.size
end

puts score