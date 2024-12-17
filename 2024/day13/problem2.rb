machines = []

class Machine
  A_COST = 3
  B_COST = 1

  attr_accessor :button_a, :button_b, :prize

  def min_prize_cost
    presses = solve
    puts presses.inspect
    puts cost(presses[0], presses[1])
    cost(presses[0], presses[1])
  end

  private

  def cost(a, b)
    return 0 if a < 0 || b < 0
    a * A_COST + b * B_COST
  end

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

    b1 = (x_p + y_p) / (x2 + y2)
    a1 = (prize[0] - (b1 * button_b[0])) / button_a[0]

    xx1 = button_a[0] * button_b[1]
    xx2 = button_b[0] * button_b[1]
    xx_p = prize[0] * button_b[1]

    yy1 = button_a[1] * -button_b[0]
    yy2 = button_b[1] * -button_b[0]
    yy_p = prize[1] * -button_b[0]

    #if ((x_p + y_p) % (x2 + y2)) != 0
      a1 = -1
    #end

    unless ((xx_p + yy_p) % (xx1 + yy1)) != 0
      bb1 = (xx_p + yy_p) / (xx1 + yy1)
      aa1 = (prize[0] - (bb1 * button_b[0])) / button_a[0]

      return [aa1, bb1] if a1 < 0 || b1 < 0
      return [a1, b1] if aa1 < 0 || bb1 < 0
      return [aa1, bb1] if cost(a1, b1) > cost(aa1, bb1)
    end

    [a1, b1]
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
    machine.prize = [$~[1].to_i + 10000000000000, $~[2].to_i + 10000000000000]
  else
    machine = Machine.new
    machines << machine
  end
end

puts machines.inject(0) { |sum, m| sum += m.min_prize_cost }
