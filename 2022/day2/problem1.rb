score = 0

$stdin.read.each_line do |s|
  opponent_move, my_move = s.chomp.split(/ /)

  case my_move
  when 'X'
    my_move = 'A'
  when 'Y'
    my_move = 'B'
  when 'Z'
    my_move = 'C'
  end

  case my_move
  when 'A'
    score += 1
  when 'B'
    score += 2
  when 'C'
    score += 3
  end

  score += 3 if my_move == opponent_move
  score += 6 if (my_move == 'A' && opponent_move == 'C') ||
    (my_move == 'B' && opponent_move == 'A') ||
    (my_move == 'C' && opponent_move == 'B')
end

puts score