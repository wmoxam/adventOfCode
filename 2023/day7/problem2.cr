class Card
  RANKS = {"A" => 13, "K" => 12, "Q" => 11, "T" => 10, "9" => 9,
    "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3,
    "2" => 2, "J" => 1}
  property :symbol

  @symbol : String

  def initialize(symbol)
    @symbol = symbol
  end

  def to_s
    symbol
  end

  def >(other)
    (RANKS[symbol] || 0) > (RANKS[other.symbol] || 0)
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

  def to_s
    "#{cards.map &.to_s} : #{bid}"
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

hands.each {|h| puts h.to_s}

winnings = 0
hands.each_with_index do |hand, i|
  winnings += hand.bid * (i + 1)
end

puts winnings