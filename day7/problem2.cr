positions = [] of Int32

ARGF.gets_to_end.each_line do |input|
  positions = input.split(/,/).map(&.to_i).sort
end

fuel_counts = {} of Int32 => Int32

(positions.first).upto(positions.last) do |i|
  fuel = 0
  positions.each do |p|
    n = (p - i).abs
    fuel += (n * (n + 1)/2).to_i
  end

  fuel_counts[i] = fuel
end

puts fuel_counts.values.sort.first
