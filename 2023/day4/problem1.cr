total = 0

STDIN.each_line do |line|
  game_s, numbers_s = line.split(/:/)
  winning_s, held_s = numbers_s.split("|")
  winning = winning_s.strip.split(/\s+/)
  held = held_s.strip.split(/\s+/)

  winners = held & winning

  total += (1 * 2**(winners.size - 1)) if winners.size > 0
end

puts total
