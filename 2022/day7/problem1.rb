
class Entry
  attr :path
  attr :files
  attr :dirs
  attr :size
  attr :parent

  def initialize(path, parent, size = 0)
  	@path = path
  	@files = []
  	@dirs = []
  	@size = size
  	@parent = parent
  end

  def add_dir(path)
  	find_dir(path) || @dirs << Entry.new(path, self)
  end

  def find_dir(path)
  	@dirs.find {|d| d.path == path}
  end

  def add_file(path, size)
  	find_file(path) || @files << Entry.new(path, self, size.to_i)
  end

  def find_file(path)
  	@files.find {|f| f.path == path}
  end

  def total_size
  	dirs.sum(&:total_size) + files.sum(&:size)
  end

  def child_dir_sizes
  	dirs.map(&:child_dir_sizes).push(total_size).flatten
  end
end


root = Entry.new('/', nil)
current = root

$stdin.read.each_line do |s|
	case s.chomp
	when /^\$ cd (.+)/
		current = if $1 == '/'
			root
		elsif $1 == ".."
			current.parent
		else
		 current.find_dir($1) || current
		end
	when /^dir (.+)/
		current.add_dir $1
	when /(\d+) (.+)/
		current.add_file($2, $1)
	end
end

puts root.child_dir_sizes.reject { |s| s >= 100000 }.sum
