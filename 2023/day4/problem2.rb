total = 0

game_cards = {}

$stdin.read.each_line.with_index do |line, y|
	game_cards[y] ||= 0
	game_cards[y] += 1

	game_s, numbers_s = line.split(/:/)
	winning_s, held_s = numbers_s.split("|")
	winning = winning_s.strip.split(/\s+/)
	held = held_s.strip.split(/\s+/)

	winners = held & winning

	if winners.length > 0
		1.upto(winners.length) do |i|
			game_cards[y+i] ||= 0
			game_cards[y+i] += game_cards[y]
		end
	end
end

puts game_cards.values.sum