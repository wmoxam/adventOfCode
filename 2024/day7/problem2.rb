equations = {}
$stdin.read.each_line do |line|
  value, nums_s = line.chomp.split(/:/)
  nums = nums_s.strip.split(/ /).map(&:to_i)
  equations[value.to_i] = nums
end

total = 0
equations.each_pair do |value, nums|
  operator_count = nums.length - 1
  ([['*', '+', '||']] * operator_count).reduce() { |acc, n| acc.product(n).map(&:flatten) }.each do |operators|
    eq = nums.zip([operators].flatten).flatten.compact
    while(sub_eq = eq.take(3); sub_eq.length == 3)
      eq = eq.drop(3)
      this_value = case sub_eq[1]
      when "||"
        (sub_eq[0].to_s + sub_eq[2].to_s).to_i
      else
        sub_eq[0].send(sub_eq[1], sub_eq[2])
      end
      eq.insert(0, this_value)
    end

    if eq[0] == value
      total += value
      break
    end
  end
end

puts total