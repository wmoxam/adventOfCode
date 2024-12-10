require "big"

map = ""
ARGF.gets_to_end.each_line do |line|
  map = line
end

disk = [] of Int32
spaces = 0

map.split(//).each_slice(2).with_index do |slice, i|
  disk.concat(Array.new(slice[0].to_i) { i })
  disk.concat(Array.new(slice[1].to_i) { -1 }) if slice.size > 1
    spaces += slice[1].to_i if slice.size > 1
end

puts "Reordering"

disk.reverse.each.with_index do |c, i|
  if idx = disk.index(-1)
    disk[idx] = c
  end
end

disk = disk[0..(disk.size - spaces - 1)]

checksum = 0.to_big_i

disk.each_with_index do |n, i|
  next if n == -1
  checksum += n.to_i * i
end

puts checksum
