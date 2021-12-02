input = ARGF.gets_to_end

position = 0
depth = 0

input.each_line do |command|
  direction, amount_s = command.split(/\s/)
  amount = amount_s.to_i

  case direction
  when "forward"
    position += amount
  when "down"
    depth += amount
  when "up"
    depth -= amount
  end
end

puts position * depth
