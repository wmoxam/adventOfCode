fish = [] of Int32

ARGF.gets_to_end.each_line do |input|
  fish = input.split(/,/).map(&.to_i)
end

1.upto(80) do |day|
  new_fish = 0
  fish = fish.map do |i|
    case i
    when 0
      new_fish += 1
      6
    else
      i - 1
    end
  end + Array.new(new_fish, 8)
end

puts fish.size
