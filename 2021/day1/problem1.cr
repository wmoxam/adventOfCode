input = ARGF.gets_to_end

previous_depth = nil
increase_count = 0

input.each_line do |depth_string|
  depth = depth_string.to_i

  unless previous_depth.nil?
    increase_count += 1 if depth > previous_depth
  end

  previous_depth = depth
end

puts increase_count
