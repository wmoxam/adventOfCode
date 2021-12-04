class Board
  property :rows

  def initialize
    @rows = [] of Array(Int32)
  end

  def diagonals
    [
      [
        rows[0][0], rows[1][1], rows[2][2], rows[3][3], rows[4][4],
      ],
      [
        rows[0][4], rows[1][3], rows[2][2], rows[3][1], rows[4][0],
      ],
    ]
  end

  def sum(numbers)
    s = 0
    rows.each do |row|
      s += (row - numbers).sum
    end
    s
  end

  def winner?(numbers)
    rows.each do |row|
      if row.all? { |i| numbers.includes?(i) }
        puts "horiz"
        p! row
        return true
      end
    end

    rows.transpose.each do |row|
      if row.all? { |i| numbers.includes?(i) }
        puts "vert"
        p! row
        return true
      end
    end

    # diagonals.each do |row|
    #   if row.all? { |i| numbers.includes?(i) }
    #     puts "diag"
    #     p! row
    #     return true
    #   end
    # end
  end
end

numbers = [] of Int32
boards = [Board.new]

i = 0
ARGF.gets_to_end.each_line do |line|
  case i
  when 0
    numbers = line.strip.split(/,/).map(&.to_i)
  else
    board = boards.last
    if board.rows.size == 5
      boards << Board.new
      board = boards.last
    end
    values = line.strip.split(/\s+/)
    next if values.size < 5
    board.rows << values.map(&.to_i)
  end
  i += 1
end

drawn_numbers = [] of Int32
found = false
non_winner = nil

numbers.each do |number|
  drawn_numbers << number

  if non_winner
    if non_winner.winner?(drawn_numbers)
      puts non_winner.sum(drawn_numbers) * number
      found = true
      break
    end
  else
    non_winners = boards.reject { |b| b.winner?(drawn_numbers) }

    if non_winners.size == 1
      non_winner = non_winners.first
    end
  end

  break if found
end
