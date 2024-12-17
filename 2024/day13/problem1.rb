machines = []

class Machine
  A_COST = 3
  B_COST = 1

  attr_accessor :button_a, :button_b, :prize

  def min_prize_cost
    presses = solve
    return 0 if presses[0] > 100 || presses[1] > 100
    return 0 if presses[0] < 0 || presses[1] < 0
    presses[0] * A_COST + presses[1] * B_COST
  end

  private

  def solve
    # (a * button_a[0]) + (b * button_b[0]) = prize[0]
    # (a * button_a[1]) + (b * button_b[1]) = prize[1]
    #
    # 94a + 22b = 8400
    # 34a + 67b = 5400
    #
    # 3196a + 748b = 285600
    # -3196a - 6298b = -507600
    #
    # 0a - 5550b = -222000
    # b = 40

    # 94a + 22 * 40 = 8400
    # 94a = 7520
    # a = 80

    x1 = button_a[0] * button_a[1]
    x2 = button_b[0] * button_a[1]
    x_p = prize[0] * button_a[1]

    y1 = button_a[1] * -button_a[0]
    y2 = button_b[1] * -button_a[0]
    y_p = prize[1] * -button_a[0]

    return [0,0] if ((x_p + y_p) % (x2 + y2)) != 0

    b = (x_p + y_p) / (x2 + y2)
    a = (prize[0] - (b * button_b[0])) / button_a[0]

    [a, b]
  end
end

machine = nil
$stdin.read.each_line do |line|
  unless machine
    machine = Machine.new
    machines << machine
  end

  case line.chomp
  when /Button A/
    line.match(/: X\+(\d+), Y\+(\d+)/)
    machine.button_a = [$~[1].to_i, $~[2].to_i]
  when /Button B/
    line.match(/: X\+(\d+), Y\+(\d+)/)
    machine.button_b = [$~[1].to_i, $~[2].to_i]
  when /Prize/
    line.match(/: X=(\d+), Y=(\d+)/)
    machine.prize = [$~[1].to_i, $~[2].to_i]
  else
    machine = Machine.new
    machines << machine
  end
end

puts machines.inject(0) { |sum, m| sum += m.min_prize_cost }
