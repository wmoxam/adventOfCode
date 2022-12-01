input = ARGF.gets_to_end

depths = [] of Int32

input.each_line do |depth_string|
  depths << depth_string.to_i
end

cohorts = [] of Int32

depths.each_cons(3) do |cons|
  cohorts << cons.reduce(0) { |acc, i| acc + i }
end

previous_depth = nil
increase_count = 0

cohorts.each do |depth|
  unless previous_depth.nil?
    increase_count += 1 if depth > previous_depth
  end

  previous_depth = depth
end

puts increase_count
