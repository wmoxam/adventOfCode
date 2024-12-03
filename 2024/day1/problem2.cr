left = [] of Int32
right = [] of Int32

ARGF.gets_to_end.each_line do |line|
  all,l,r = line.split(/(\d+)\s+(\d+)/)
  left << l.to_i
  right << r.to_i
end

left.sort!
right.sort!
right_map = right.tally

score = 0

left.each do |l|
  score += l * (right_map[l]? || 0).to_i
end

puts score