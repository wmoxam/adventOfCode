stones = [] of String

ARGF.gets_to_end.each_line do |line|
  stones = line.chomp.split(/ /)
end

memo = {} of String => Array(String)
memo["0"] = ["1"]

75.times do |n|
  puts "Blink #{n}"
  next_i = 0
  stones.each_with_index do |s, i|
    next unless i == next_i

    next_i += 1
    if memo.has_key?(s)
      stones[i,1] = memo[s]
    elsif s.size % 2 == 0
      memo[s] = [s[0..((s.size / 2).to_i64 - 1)], s[(s.size / 2).to_i..-1].to_i64.to_s]
      stones[i,1] = memo[s]
      next_i += 1
    else
      memo[s] = [(s.to_i64 * 2024).to_s]
      stones[i,1] = memo[s]
    end
  end

  puts stones.size
end

puts stones.size
