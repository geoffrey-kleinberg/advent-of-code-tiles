input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i.to_i)
	end
end
def part1(input)
	input = input.sort
	input.append(input.max + 3)
	input = [0] + input
	ones = 0
	threes = 0
	for i in 0...(input.length - 1)
		diff = input[i + 1] - input[i]
		ones += 1 if diff == 1
		threes += 1 if diff == 3
	end
	return ones * threes
end
def f(start, input, numMap)
	sum = 0
	this_in = input
	return numMap[start] if numMap[start]
	return 0 if not this_in.include? start
	return 1 if start == this_in.max
	for i in 1..3
		sum += f(start + i, this_in, numMap) { |i, j| numMap[i] = j }
	end
	yield start, sum
	return sum
end
def part2(input)
	numMap = {}
	input = ([0] + input.append(input.max + 3))
	return f(0, input, numMap) { |i, j| numMap[i] = j}
end
puts part1(input)
t = Time.now
puts part2(input)
puts Time.now - t