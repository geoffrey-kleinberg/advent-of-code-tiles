input = []
File.open("input.txt") do |f|
	f.each do |l|
		input << l.to_i
	end
end
def part1(input)
	for i in input
		if input.include? (2020 - i)
			return i * (2020 - i)
			break
		end
	end
end
def part2(input)
	done = false
	for i in input
		for j in input
			if input.include? (2020 - i - j)
				return i * j * (2020 - i - j)
				done = true and break
			end
			break if done
		end
		break if done
	end
end
puts part1(input)
puts part2(input)