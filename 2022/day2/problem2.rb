score = 0

$stdin.read.each_line do |s|
  opponent_move, result = s.chomp.split(/ /)

  # X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
  score += 3 if result == 'Y'
  score += 6 if result == 'Z'

  case result
  when 'X'
    my_move = 'A' if opponent_move == 'B'
    my_move = 'B' if opponent_move == 'C'
    my_move = 'C' if opponent_move == 'A'
  when 'Y'
    my_move = 'A' if opponent_move == 'A'
    my_move = 'B' if opponent_move == 'B'
    my_move = 'C' if opponent_move == 'C'
  when 'Z'
    my_move = 'A' if opponent_move == 'C'
    my_move = 'B' if opponent_move == 'A'
    my_move = 'C' if opponent_move == 'B'
  end

  case my_move
  when 'A'
    score += 1
  when 'B'
    score += 2
  when 'C'
    score += 3
  end
end

puts score