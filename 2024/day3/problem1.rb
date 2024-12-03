total = 0
$stdin.read.each_line do |line|
  matches = line.scan(/(mul\(\d\d?\d?,\d\d?\d?\))/)
  matches.each do |match|
    a, b = match[0].scan(/\d+/)
    total += a.to_i * b.to_i
  end
end

puts total