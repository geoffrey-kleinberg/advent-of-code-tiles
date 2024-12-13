lines = []
File.open("input.txt") do |f|
	f.each do |i|
		lines << i
	end
end
def binTo10(bin)
	val = 0
	bin.split("").each.with_index do |i, j|
		val += i.to_i * (2 ** (bin.length - j - 1))
	end
	return val
end
def part1(lines)
	highest = -1
	for i in lines
		row = binTo10(i.slice(0, 7).split("").map { |i| (i == "B") ? 1 : 0}.join)
		col = binTo10(i.slice(7, 3).split("").map { |i| (i == "R") ? 1 : 0}.join)
		val = row * 8 + col
		(val > highest) ? (highest = val) : nil
	end
	return highest
end
def part2(lines)
	seats = (0..858).to_a
	for i in lines
		row = binTo10(i.slice(0, 7).split("").map { |i| (i == "B") ? 1 : 0}.join)
		col = binTo10(i.slice(7, 3).split("").map { |i| (i == "R") ? 1 : 0}.join)
		val = row * 8 + col
		seats.delete(val)
	end
	for i in seats
		return i if not (seats.include? (i + 1) or seats.include? (i - 1))
	end
end
puts part1(lines)
puts part2(lines)