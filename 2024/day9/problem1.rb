map = ""
$stdin.read.each_line do |line|
  map = line
end

disk = []
spaces = 0

map.split(//).each_slice(2).with_index do |slice, i|
  disk.concat(Array.new(slice[0].to_i) { i })
  disk.concat(Array.new(slice[1].to_i) { nil })
  spaces += slice[1].to_i
end

disk.reverse.each.with_index do |c, i|
  disk[disk.index(nil)] = c if disk.index(nil)
end

disk = disk[0..(disk.length - spaces - 1)]

checksum = 0

disk.each_with_index do |n, i|
  checksum += n.to_i * i
end

puts checksum
