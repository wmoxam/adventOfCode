class Card
	 RANKS = {"A" => 13, "K" => 12, "Q" => 11, "T" => 10, "9" => 9,
    "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3,
    "2" => 2, "J" => 1}
	attr_reader :symbol

	def initialize(symbol)
		@symbol = symbol
	end

	def >(other)
		RANKS[symbol] > RANKS[other.symbol]
  end

  def ==(other)
  	symbol == other.symbol
  end

  def wildcard?
  	symbol == 'J'
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
  	@group_lengths ||= begin
  		wildcards = cards.select &:wildcard?
  		remaining = cards.reject &:wildcard?
  		lengths = remaining.group_by{|e| e.symbol}.map{|k, v| v.length}.sort

  		if lengths.size > 0
	  		lengths[-1] += wildcards.length
  		else
  			# all wildcards
  			return [5]
  		end

  		lengths
  	end
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