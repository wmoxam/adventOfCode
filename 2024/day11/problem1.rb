stones = []

$stdin.read.each_line do |line|
  stones = line.chomp.split(/ /)
end

25.times do
  new_stones = []

  stones.each do |s|
    if s == "0"
      new_stones << "1"
    elsif s.size % 2 == 0
      new_stones << s[0..(s.size / 2 - 1)]
      new_stones << s[(s.size / 2)..-1].to_i.to_s
    else
      new_stones << (s.to_i * 2024).to_s
    end
  end
  stones = new_stones
end

puts stones.size
