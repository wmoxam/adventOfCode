class Card
	RANKS = %w(A K Q T 9 8 7 6 5 4 3 2 J)
	attr_reader :symbol

	def initialize(symbol)
		@symbol = symbol
	end

	def to_s
		symbol
	end

	def >(other)
		RANKS.index(symbol) < RANKS.index(other.symbol)
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

  def to_s
  	"#{cards.join}, #{bid}, #{type_rank}"
  end

  def type_rank
  	return 7 if five_of_a_kind?
  	return 6 if four_of_a_kind?
  	return 5 if full_house?
  	return 4 if three_of_a_kind?
  	return 3 if two_pair?
  	return 2 if pair?
  	return 1
  end

  def five_of_a_kind?
  	group_lengths == [5]
  end

  def four_of_a_kind?
  	group_lengths == [1, 4]
  end

  def full_house?
  	group_lengths == [2, 3]
  end

  def three_of_a_kind?
  	group_lengths == [1, 1, 3]
  end

  def two_pair?
  	group_lengths == [1, 2, 2]
  end

  def pair?
  	group_lengths == [1, 1, 1, 2]
  end

  def high_card?
  	group_lengths == [1, 1, 1, 1, 1]
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

hands.sort! {|a,b| a <=> b }

winnings = 0
hands.each_with_index do |hand, i|
	winnings += hand.bid * (i + 1)
end

puts winnings