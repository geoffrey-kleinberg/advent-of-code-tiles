input = []
File.open("input.txt") do |f|
	f.each do |i|
		input = i.split(",").map { |i| i.to_i }
	end
end
def part1(input)
	while input.length < 2020
		recent = input[-1]
		if input.count(recent) == 1
			input.append(0)
		else
			input.append(input.reverse.slice(1, input.length - 1).index(recent) + 1)
		end
	end
	#print(input)
	#puts
	return input[2019]
end
def part2(input)
	lastInds = {}
	input.each.with_index do |i, ind|
		lastInds[i] = [ind]
	end
	last = input.slice(-1)
	ind = input.length
	while ind < 30000000
		puts ind if ind % 1000000 == 0
		#^^ this is to watch the progress
		if lastInds[last].length == 1
			nextNum = 0
			if lastInds[nextNum].length == 1
				lastInds[nextNum].append(ind)
			else
				lastInds[nextNum][0] = lastInds[nextNum][1]
				lastInds[nextNum][1] = ind
			end
		else
			nextNum = lastInds[last][1] - lastInds[last][0]
			if lastInds[nextNum]
				if lastInds[nextNum].length == 1
					lastInds[nextNum].append(ind)
				else
					lastInds[nextNum][0] = lastInds[nextNum][1]
					lastInds[nextNum][1] = ind
				end
			else
				lastInds[nextNum] = [ind]
			end
		end
		ind += 1
		last = nextNum
	end
	return last
end
puts part1(input)
puts part2(input)