$stdin.read.each_line do |s|
	set = []
	chars = s.split("")

	0.upto(chars.length - 14) do |i|
		if chars[i..i+13].uniq.length == 14
			puts i + 14
			break
		end	
	end
end
