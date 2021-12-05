coords = [] of String

ARGF.gets_to_end.each_line do |input|
  matches = /(\d+),(\d+) -> (\d+),(\d+)/.match(input)

  if matches.nil?
    next
  else
    x1 = matches[1].to_i
    y1 = matches[2].to_i
    x2 = matches[3].to_i
    y2 = matches[4].to_i

    if x1 == x2
      Math.min(y1, y2).upto(Math.max(y1, y2)) do |y|
        coords << "#{x1},#{y}"
      end
    elsif y1 == y2
      Math.min(x1, x2).upto(Math.max(x1, x2)) do |x|
        coords << "#{x},#{y1}"
      end
    else
      p! x1, y1, x2, y2
      if x1 > x2 && y1 > y2
        x2.upto(x1) do |x|
          coords << "#{x},#{y2 + (x - x2)}"
        end
      elsif x1 > x2 && y1 < y2
        x2.upto(x1) do |x|
          coords << "#{x},#{y2 - (x - x2)}"
        end
      elsif x1 < x2 && y1 > y2
        x1.upto(x2) do |x|
          coords << "#{x},#{y1 - (x - x1)}"
        end
      elsif x1 < x2 && y1 < y2
        x1.upto(x2) do |x|
          coords << "#{x},#{y1 + (x - x1)}"
        end
      end
    end
  end
end

puts coords.tally.values.select { |v| v > 1 }.size
