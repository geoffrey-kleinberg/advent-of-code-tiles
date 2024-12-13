lines = []
File.open("input.txt") do |f|
	f.each do |i|
		lines.append(i.strip)
	end
end
def part1(input)
	trees = 0
	horizLoc = 0
	for i in input
		trees += 1 if i.slice(horizLoc % (i.length)) == "#"
		horizLoc += 3
	end
	return trees
end
def part2(input)
	treeProd = 1
	for l in [1, 3, 5, 7]
		trees = 0
		horizLoc = 0
		for i in input
			trees += 1 if i.slice(horizLoc % (i.length)) == "#"
			horizLoc += l
		end
		treeProd *= trees
		#puts trees
		#puts treeProd
	end
	horizLoc = 0
	trees = 0
	i = 0
	while i < input.length - 1
		trees += 1 if input[i].slice(horizLoc % input[i].length) == "#"
		i += 2
		horizLoc += 1
	end
	treeProd *= trees
	#puts trees
	return treeProd
end
puts part1(lines)
puts part2(lines)