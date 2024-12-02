safe = []
$stdin.read.each_line do |report|
  digits = report.split(/\s+/).map(&:to_i)

  next unless digits == digits.sort || digits == digits.sort.reverse

  ok = true
  last = digits.first
  digits[1..-1].each do |d|
    abs = (last - d).abs
    if abs < 1 || abs > 3
      ok = false
      break
    end
    last = d
  end

  next unless ok

  safe << report
end

puts safe.size