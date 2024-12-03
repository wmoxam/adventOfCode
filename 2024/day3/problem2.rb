total = 0
enabled = true
$stdin.read.each_line do |line|
  matches = line.scan(/((mul\(\d{1,3},\d{1,3}\)|(do(n't)?\(\))))/)
  matches.each do |match|
    case match[0]
    when "do()"
      enabled = true
    when "don't()"
      enabled = false
    else
      if enabled
        a, b = match[0].scan(/\d+/)
        total += a.to_i * b.to_i
      end
    end
  end
end

puts total