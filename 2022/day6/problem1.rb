$stdin.read.each_line do |s|
	set = []
	s.split("").each_with_index do |c,i|
		if set.length == 4
			set.slice!(0,1)
		end
		set << c
		if set.uniq.length == 4
			puts i + 1
			break
		end	
	end
end
