#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

# 0 : 6
# 1 : 2
# 2 : 5
# 3 : 5
# 4 : 4
# 5 : 5
# 6 : 7
# 7 : 3
# 8 : 7
# 9 : 6

inputs = [] of String
outputs = [] of String

n = 0

def calc(inputs, outputs)
  knowns = inputs.uniq.select { |s| [2, 3, 4, 7].includes?(s.size) }
  unknowns = (inputs.uniq - knowns).map { |s| s.split(//) }

  one = inputs.select { |s| s.size == 2 }.first.split(//)
  four = inputs.select { |s| s.size == 4 }.first.split(//)
  seven = inputs.select { |s| s.size == 3 }.first.split(//)
  eight = inputs.select { |s| s.size == 7 }.first.split(//)

  two = unknowns.select { |s| s.size == 5 }.select { |s| (s - four).size == 3 }.first
  unknowns = unknowns.reject { |s| s.size == 5 && (s - four).size == 3 }

  three = unknowns.select { |s| s.size == 5 }.select { |s| (s - two).size == 1 }.first
  five = unknowns.select { |s| s.size == 5 }.select { |s| (s - two).size != 1 }.first

  unknowns = unknowns.reject { |s| s.size == 5 }

  six = unknowns.select { |s| (s - one).size == 5 }.first
  unknowns = unknowns.reject { |s| (s - one).size == 5 }

  nine = unknowns.select { |s| (s - three).size == 1 }.first
  zero = unknowns.select { |s| (s - three).size != 1 }.first

  display_map = [zero, one, two, three, four, five, six, seven, eight, nine]
  out_num = ""

  outputs.each do |output_s|
    output = output_s.split(//)
    display_map.each_with_index do |d, i|
      if output.size == d.size && output.all? { |s| d.includes?(s) }
        out_num += i.to_s
        break
      end
    end
  end

  out_num.to_i
end

ARGF.gets_to_end.each_line do |input|
  input, output = input.split(/\|/)
  inputs = input.split(/\s+/)
  outputs = output.strip.split(/\s+/)

  n += calc(inputs, outputs)
end

puts n
