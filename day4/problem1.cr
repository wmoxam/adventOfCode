class Board
  property :rows

  def initialize
    @rows = [] of Array(Int32)
  end

  # def diagonals
  #   [
  #     [
  #       rows[0][0], rows[1][1], rows[2][2], rows[3][3], rows[4][4],
  #     ],
  #     [
  #       rows[0][4], rows[1][3], rows[2][2], rows[3][1], rows[4][0],
  #     ],
  #   ]
  # end

  def sum(numbers)
    s = 0
    rows.each do |row|
      s += (row - numbers).sum
    end
    s
  end

  def winner?(numbers)
    rows.each do |row|
      return true if row.all? { |i| numbers.includes?(i) }
    end

    rows.transpose.each do |row|
      return true if row.all? { |i| numbers.includes?(i) }
    end

    # diagonals.each do |row|
    #   return true if row.all? { |i| numbers.includes?(i) }
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

numbers.each do |number|
  drawn_numbers << number

  boards.each do |board|
    if board.winner?(drawn_numbers)
      puts board.sum(drawn_numbers) * number
      found = true
      break
    end
  end

  break if found
end
