left = []
right = []

$stdin.read.each_line do |line|
  all,l,r = line.split(/(\d+)\s+(\d+)/)
  left << l.to_i
  right << r.to_i
end

left.sort!
right.sort!

diff = 0

left.each_with_index do |l, i|
  r = right[i]
  diff += (l - r).abs
end

puts diff