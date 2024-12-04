@board = []
$stdin.read.each_line do |line|
  @board << line
end

def find_xmas(x, y, x_delta, y_delta)
  return 0 if @board[y + (3 * y_delta)] == nil ||
    @board[y + (3 * y_delta)][x + (3 * x_delta)] == nil

  return 1 if (@board[y + y_delta][x + x_delta] +
               @board[y + (2 * y_delta)][x + (2 * x_delta)] +
               @board[y + (3 * y_delta)][x + (3 * x_delta)] == "MAS")

  return 0
end

total = 0
@board.each_with_index do |row, y|
  while(x = row.index("X"))
    total += find_xmas(x, y, -1, 0)
    total += find_xmas(x, y, -1, -1)
    total += find_xmas(x, y, 0, -1)
    total += find_xmas(x, y, 1, -1)
    total += find_xmas(x, y, 1, 0)
    total += find_xmas(x, y, 1, 1)
    total += find_xmas(x, y, 0, 1)
    total += find_xmas(x, y, -1, 1)
    row[x] = "."
  end
end

puts total