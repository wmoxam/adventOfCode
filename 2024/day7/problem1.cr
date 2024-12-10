equations = {} of Int64 => Array(Int64)
ARGF.gets_to_end.each_line do |line|
  value, nums_s = line.chomp.split(/:/)
  nums = nums_s.strip.split(/ /).map(&.to_i64)
  equations[value.to_i64] = nums
end

total = 0.to_i64
equations.each do |value, all_nums|
  operator_count = all_nums.size - 1
  (['*', '+'] * operator_count).combinations(operator_count).to_a.uniq.each do |operators|
    nums = all_nums.dup
    while(nums.size > 1)
      a = nums.shift
      b = nums.shift
      op = operators.shift

      this_value = case op
      when '+'
        a + b
      when '*'
        a * b
      else
        puts op
        0
      end.to_i64

      nums.insert(0, this_value)
    end

    if nums[0] == value
      total += value
      break
    end
  end
end

puts total