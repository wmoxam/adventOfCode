safe = []
$stdin.read.each_line do |report|
  all_digits = report.split(/\s+/).map(&:to_i)

  all_digits.combination(all_digits.size - 1).each do |digits|
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
    break
  end
end

puts safe.size
