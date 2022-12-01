gamma_rate = 0

numbers = [] of Int32

ARGF.gets_to_end.each_line do |input|
  numbers << input.to_i(2)
end

threshold = (numbers.size / 2).to_i

0.upto(16) do |i|
  gamma_rate += 2 ** i if numbers.select { |n| n.bit(i) == 1 }.size > threshold
end

puts gamma_rate
puts gamma_rate ^ 0b11111
puts gamma_rate ^ 0b111111111111

puts gamma_rate * (gamma_rate ^ 0b11111)
puts gamma_rate * (gamma_rate ^ 0b111111111111)
