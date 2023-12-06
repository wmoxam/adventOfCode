time = nil
distance = nil

$stdin.read.each_line do |line|
	case line
	when /Time:/
		time = line.split(/:/)[1].strip.gsub(/\s+/, '').to_i
	else
		distance = line.split(/:/)[1].strip.gsub(/\s+/, '').to_i
	end
end

results = []

lower_hold = 1

1.upto(time) do |hold_time|
	lower_hold = hold_time
	break if ((time - hold_time) * hold_time) > distance
end

upper_hold = time

time.downto(1) do |hold_time|
	upper_hold = hold_time
	break if ((time - hold_time) * hold_time) > distance
end

results << upper_hold - lower_hold + 1

puts results.inject(1) {|prod, i| prod * i }