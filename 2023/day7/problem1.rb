class Card
	RANKS = %w(A K Q J T 9 8 7 6 5 4 3 2)
	attr_reader :symbol

	def initialize(symbol)
		@symbol = symbol
	end

	def >(other)
		RANKS.index(symbol) < RANKS.index(other.symbol)
  end

  def ==(other)
  	symbol == other.symbol
  end
end

class Hand
	attr_reader :cards, :bid

	def initialize(cards, bid)
		@cards = cards.split(//).map {|c| Card.new(c) }
		@bid = bid.to_i
	end

	def <=>(other)
		if type_rank == other.type_rank
			cards.each.with_index do |card, i|
				next if card == other.cards[i]
				return card > other.cards[i] ? 1 : -1
			end

			return 0
		elsif type_rank > other.type_rank
			return 1
		else
			-1
		end
  end

  def type_rank
  	return 7 if group_lengths == [5]
  	return 6 if group_lengths == [1, 4]
  	return 5 if group_lengths == [2, 3]
  	return 4 if group_lengths == [1, 1, 3]
  	return 3 if group_lengths == [1, 2, 2]
  	return 2 if group_lengths == [1, 1, 1, 2]
  	return 1
  end

  def group_lengths
  	@group_lengths ||= cards.group_by{|e| e.symbol}.map{|k, v| v.length}.sort
  end
end

hands = []

$stdin.read.each_line do |line|
	cards, bid = line.split(/\s/)
	hands << Hand.new(cards, bid)
end

hands.sort!

winnings = 0
hands.each_with_index do |hand, i|
	winnings += hand.bid * (i + 1)
end

puts winnings