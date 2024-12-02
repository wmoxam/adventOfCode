input = %w(
-6 +3 +8 +5 -6
)

seen = []
sum = 0
found = false
while true do
  puts "LOOP #{seen.length}"
  input.each do |vector|
    sum += vector.to_i

    if seen.include?(sum)
      puts "FOUND"
      found = true
      break
    else
      seen << sum
    end
  end

  break if found
end

puts sum