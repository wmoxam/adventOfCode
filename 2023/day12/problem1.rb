records = []

$stdin.read.each_line do |line|
	layout, counts = line.strip.split(/\s/)
	records << [layout.split(//), counts.split(/,/).map(&:to_i)]
end

def calc(format, counts)

end

arangements = 0
records.each do |record|
	arangements += calc(record[0], record[1])
end

<<-DOC
???.?#????? 1,5

. . . . .  <- these
# #####    <- every combination in this

#.....#####
.#....#####
#....#####.
..#...#####
#...#####..
...#..#####
....#.#####
...#.#####.
..#.#####..
.#.#####...
#.#####....
..#..#####.
.#..#####..
#..#####...
.#..#####..
..#..#####.
...#..#####
..#...#####
.#...#####.


DOC