lines = []
File.open("input.txt") do |f|
	f.each do |i|
		lines.append(i.strip)
	end
end
def part1(input)
	visited = []
	index = 0
	accumulator = 0
	while not visited.include? index and index < input.length
		visited.append(index)
		instruct = input[index]
		index += 1
		next if instruct.slice(0, 3) == "nop"
		if instruct.slice(0, 3) == "acc"
			increase = instruct.slice(4, instruct.length - 4).to_i
			accumulator += increase
		else
			skip = instruct.slice(4, instruct.length - 4).to_i
			index += skip - 1
		end
	end
	yield index
	return accumulator
end
def part2(lines)
	for i in 0...lines.length
		oLine = lines[i]
		next if lines[i].slice(0, 3) == "acc"
		if lines[i].slice(0, 3) == "nop"
			lines[i] = "jmp" + oLine.slice(3, oLine.length - 3)
		else
			lines[i] = "nop"
		end
		part1(lines) do |j|
			if j >= lines.length
				return part1(lines) { |i| i }
			end
		end
		lines[i] = oLine
	end
end
puts part1(lines) { |i| i }
puts part2(lines)