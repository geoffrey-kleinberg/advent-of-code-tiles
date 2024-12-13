lines = []
File.open("input.txt") do |f|
	f.each do |i|
		lines.append(i.strip.to_i)
	end
end
def part1(input)
	backLen = 25
	nums = input.slice(0, backLen)
	for i in backLen...input.length
		valid = false
		for j in nums
			valid = true and break if nums.include? input[i] - j
		end
		nums.delete_at(nums.index(nums[0]))
		nums.append(input[i])
		return input[i] if not valid
	end
end
def part2(input)
	goal = part1(input)
	for i in 0...input.length
		sum = input[i]
		nums = [input[i]]
		start = 1
		while sum < goal
			sum += input[i + start]
			nums.append(input[i + start])
			start += 1
		end
		if sum == goal
			return nums.min + nums.max
		end
	end
end
puts part1(lines)
puts part2(lines)