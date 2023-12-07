class Card
  RANKS = %w(A K Q T 9 8 7 6 5 4 3 2 J)
  property :symbol

  @symbol : String

  def initialize(symbol)
    @symbol = symbol
  end

  def >(other)
    (RANKS.index(symbol) || 0) < (RANKS.index(other.symbol) || 0)
  end

  def ==(other)
    symbol == other.symbol
  end

  def wildcard?
    symbol == 'J'
  end
end

class Hand
  property :cards, :bid

  @bid : Int32
  @cards : Array(Card)

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
    lengths = group_lengths
    return 7 if lengths == [5]
    return 6 if lengths == [1, 4]
    return 5 if lengths == [2, 3]
    return 4 if lengths == [1, 1, 3]
    return 3 if lengths == [1, 2, 2]
    return 2 if lengths == [1, 1, 1, 2]
    return 1
  end

  def group_lengths
    wildcards = cards.select &.wildcard?
    remaining = cards.reject &.wildcard?
    lengths = remaining.group_by{|e| e.symbol}.map{|k, v| v.size}.sort

    if lengths.size > 0
      lengths[-1] += wildcards.size
    else
      # all wildcards
      return [5]
    end

    lengths
  end
end

hands = [] of Hand

STDIN.each_line do |line|
  cards, bid = line.split(/\s/)
  hands << Hand.new(cards, bid)
end

hands.sort!

winnings = 0
hands.each_with_index do |hand, i|
  winnings += hand.bid * (i + 1)
end

puts winnings