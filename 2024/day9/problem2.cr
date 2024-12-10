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


def next_free_block_of_size_idx(disk, length)
  start = -1
  count = 0
  disk.each_with_index do |c, i|
    if c != -1
      start = -1
      count = 0
      next
    end

    count += 1
    start = i if start < 0
    return start if count == length
  end
  return -1
end

reverse = disk.reverse

moved = [] of Int32

reverse.each.with_index do |c, i|
  next if c == -1
  if end_pos = reverse.index(c)
    if start_pos = disk.index(c)
      next if start_pos > disk.size - 1 - i
      length = disk.size - end_pos - start_pos

      idx = next_free_block_of_size_idx(disk, length)

      next if idx < 0 || idx > start_pos

      disk[idx, length] = ([c] * length)
      disk[disk.size - i - length, length] = ([-1] * length)
    end
  end
end

checksum = 0.to_big_i

disk.each_with_index do |n, i|
  next if n == -1
  checksum += n.to_i * i
end

puts checksum
