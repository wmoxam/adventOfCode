fish = {} of Int8 => Int64
0_i8.upto(8_i8) do |i|
  fish[i] = 0.to_i64
end

ARGF.gets_to_end.each_line do |input|
  input.split(/,/).map { |s| fish[s.to_i8] += 1 }
end

p! fish

1.upto(256) do |day|
  new_fish = 0
  new_fish_hash = {} of Int8 => Int64
  0_i8.upto(8_i8) do |i|
    new_fish_hash[i] = 0.to_i64
  end

  fish.each do |key, value|
    case key
    when 0
      new_fish = value
      new_fish_hash[6] ||= 0
      new_fish_hash[6] += value
    when 7
      new_fish_hash[6] ||= 0
      new_fish_hash[6] += value
    else
      new_fish_hash[key - 1] = value
    end
  end

  fish = new_fish_hash.dup
  fish[8_i8] = new_fish.to_i64
end

puts fish.values.sum
