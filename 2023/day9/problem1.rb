histories = []

$stdin.read.each_line do |line|
	histories << line.split(/\s+/).map(&:to_i)
end

def get_diff(h)
	d = []
	last = nil
	h.each do |i|
		if last
			d << i - last
		end

		last = i
	end

	d
end

extrapolated_values = histories.map do |h|
	diffs = [h]
	diff = get_diff(h)
	loop do
		diffs << diff
		break if diff.all? {|i| i == 0}
		diff = get_diff(diff)
	end

	last = 0
	extrapolated_value = 0
	diffs.reverse.each.with_index do |diff, i|
		num = diff.last + last
		diff << num

		if i == (diffs.length - 1)
			extrapolated_value = num
		end

		last = num
	end

	extrapolated_value
end

puts extrapolated_values.sum