o2_rating = 0
co2_rating = 0

o2_numbers = [] of Int32

ARGF.gets_to_end.each_line do |input|
  o2_numbers << input.to_i(2)
end

co2_numbers = o2_numbers.dup

bit_length = o2_numbers.map(&.bit_length).max - 1

bit_length.downto(0) do |i|
  if o2_numbers.select { |n| n.bit(i) == 1 }.size >= (o2_numbers.size / 2).ceil
    o2_numbers = o2_numbers.select { |n| n.bit(i) == 1 }
  else
    o2_numbers = o2_numbers.select { |n| n.bit(i) == 0 }
  end

  if o2_numbers.size == 1
    o2_rating = o2_numbers.first
    break
  end
end

bit_length.downto(0) do |i|
  if co2_numbers.select { |n| n.bit(i) == 0 }.size <= (co2_numbers.size / 2).floor
    co2_numbers = co2_numbers.select { |n| n.bit(i) == 0 }
  else
    co2_numbers = co2_numbers.select { |n| n.bit(i) == 1 }
  end

  if co2_numbers.size == 1
    co2_rating = co2_numbers.first
    break
  end
end

puts o2_rating
puts co2_rating

puts o2_rating * co2_rating
