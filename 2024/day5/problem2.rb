rules = {}
updates = []

$stdin.read.each_line do |line|
  if line.index("|")
    a, b = line.chomp.split("|")
    rules[a] ||= []
    rules[a] << b
  elsif line.index(",")
    updates << line.chomp
  end
end

valid_sum = 0
invalid_sum = 0

updates.each do |update|
  pages = update.split(/,/)
  valid = true
  pages.each_with_index do |page, i|
    if pages[i+1..-1].any? { |p| rules[p] && rules[p].include?(page) }
      valid = false
      break
    end
  end

  if valid
    valid_sum += pages[pages.length / 2].to_i
  else
    ordered = pages.sort do |a,b|
      rules[a] && rules[a].include?(b) ? -1 : 1
    end
    invalid_sum += ordered[pages.length / 2].to_i
  end
end

puts "Valid: #{valid_sum}, Invalid: #{invalid_sum}"