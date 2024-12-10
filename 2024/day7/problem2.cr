require "big"

puts "Start"

equations = {} of BigInt => Array(BigInt)
ARGF.gets_to_end.each_line do |line|
  value, nums_s = line.chomp.split(/:/)
  nums = nums_s.strip.split(/ /).map(&.to_big_i)
  equations[value.to_big_i] = nums
end

puts "Parsed input"

total = 0.to_big_i
equations.each do |value, all_nums|
  puts "checking eq #{value}"
  operator_count = all_nums.size - 1
  puts "with operator count #{operator_count}"
  (['*', '+', '|'] * operator_count).combinations(operator_count).to_a.uniq.each do |operators|
    puts "checking for ops #{operators}"
    nums = all_nums.dup
    puts "after DUP"
    while(nums.size > 1)

      a = nums.shift
      b = nums.shift
      op = operators.shift

      begin
        this_value = case op
        when '+'
          a + b
        when '*'
          a * b
        when '|'
          (a.to_s + b.to_s)
        else
          0
        end.to_big_i

        nums.insert(0, this_value)
      rescue OverflowError
        puts "OVERFLOW 1: #{a} #{op} #{b}"
        exit(1)
      end
    end

    begin
      if nums[0] == value
        total += value
        break
      end
    rescue OverflowError
      puts "OVERFLOW 2: #{total} += #{value}"
      exit(1)
    end
  end
end

puts total