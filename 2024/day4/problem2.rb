@board = []
$stdin.read.each_line do |line|
  @board << line
end

def find_x_mas(x, y)
  return 0 if @board[y - 1] == nil
  return 0 if @board[y + 1] == nil

  #  M.M
  #  .A.
  #  S.S
  return 1 if @board[y - 1][x - 1] == "M" && @board[y + 1][x + 1] == "S" &&
              @board[y - 1][x + 1] == "M" && @board[y + 1][x - 1] == "S"
  #  S.M
  #  .A.
  #  S.M
  return 1 if @board[y - 1][x - 1] == "S" && @board[y + 1][x + 1] == "M" &&
              @board[y - 1][x + 1] == "M" && @board[y + 1][x - 1] == "S"

  #  S.S
  #  .A.
  #  M.M
  return 1 if @board[y - 1][x - 1] == "S" && @board[y + 1][x + 1] == "M" &&
              @board[y - 1][x + 1] == "S" && @board[y + 1][x - 1] == "M"

  #  M.S
  #  .A.
  #  M.S
  return 1 if @board[y - 1][x - 1] == "M" && @board[y + 1][x + 1] == "S" &&
              @board[y - 1][x + 1] == "S" && @board[y + 1][x - 1] == "M"

  return 0
end

total = 0
@board.each_with_index do |row, y|
  while(x = row.index("A"))
    total += find_x_mas(x, y)
    row[x] = "."
  end
end

puts total