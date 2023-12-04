total = 0

game_cards = {} of Int32 => Int32

y = 0

STDIN.each_line do |line|
  game_cards[y] ||= 0
  game_cards[y] += 1

  game_s, numbers_s = line.split(/:/)
  winning_s, held_s = numbers_s.split("|")
  winning = winning_s.strip.split(/\s+/)
  held = held_s.strip.split(/\s+/)

  winners = held & winning

  if winners.size > 0
    1.upto(winners.size) do |i|
      game_cards[y + i] ||= 0
      game_cards[y + i] += game_cards[y]
    end
  end

  y += 1
end

puts game_cards.values.sum
