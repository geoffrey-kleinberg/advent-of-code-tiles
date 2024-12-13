input = []
File.open("input.txt") do |f|
	nextL = ""
	f.each do |i|
		if i != "\n"
			nextL += i.strip
		else
			input.append(nextL)
			nextL = ""
		end
	end
	input.append(nextL)
end
def part1(input)
	sum = 0
	for i in input
		modif = ""
		for j in i.split("")
			modif += j if not modif.split("").include? j
		end
		sum += modif.length
	end
	return sum
end
puts part1(input)
input = []
File.open("input.txt") do |f|
	nextL = []
	f.each do |i|
		if i != "\n"
			nextL.append(i.strip)
		else
			input.append(nextL)
			nextL = []
		end
	end
	input.append(nextL)
end
def part2(input)
	sum = 0
	for i in input
		for j in "abcdefghijklmnopqrstuvwxyz".split("")
			works = true
			for k in i
				if not k.split("").include? j
					works = false
					break
				end
			end
			sum += 1 if works
		end
	end
	return sum
end
puts part2(input)