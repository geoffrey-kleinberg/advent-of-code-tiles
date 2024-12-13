time = 0
busses = []
File.open("input.txt") do |f|
	first = true
	f.each do |i|
		if first
			time = i.to_i
			first = false
		else
			busses = i.split(",").map { |j| (j == "x") ? nil : j.to_i }.compact
		end
	end
end
def part1(time, busList)
	min = Float::INFINITY
	best = 0
	for i in busList
		wait = i - (time % i)
		(wait < min) ? (min = wait and best = i) : (nil)
	end
	puts min * best
end
puts part1(time, busses)
busses = []
File.open("input.txt") do |f|
	first = true
	f.each do |i|
		if first
			first = false
		else
			busses = i.split(",").map { |j| (j == "x") ? "x" : j.to_i }
		end
	end
end
def part2(busses)
	modMap = {}
	for i in busses
		if i != "x"
			modMap[i] = (i - busses.index(i)) % i
		end
	end
	t = modMap[modMap.keys.max]
	indices = modMap.keys.sort.reverse
	add = 1
	indices.each.with_index do |i, ind|
		next if ind == indices.length - 1
		add *= i
		while t % indices[ind + 1] != modMap[indices[ind + 1]]
			t += add
		end
	end
	return t
end
puts part2(busses)