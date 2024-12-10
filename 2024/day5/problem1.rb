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

sum = 0

updates.each do |update|
  pages = update.split(/,/)
  valid = true
  pages.each_with_index do |page, i|
    if pages[i+1..-1].any? { |p| rules[p] && rules[p].include?(page) }
      valid = false
      break
    end
  end

  sum += pages[pages.length / 2].to_i if valid
end

puts sum