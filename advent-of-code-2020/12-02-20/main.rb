inLines = []
File.open("input.txt") do |f|
	f.each do |l|
		inLines << l
	end
end
pols = inLines.map { |i| i.split(": ")[0] }
passwords = inLines.map { |i| i.split(": ")[1]}
polMap = pols.inject([]) do |pMap, pol|
	pMap << [pol.split(" ")[1], [pol.split("-")[0].to_i, pol.split("-")[1].split(" ")[0].to_i]]
	pMap
end
def part1(passwords, polMap)
	valid = 0
	for i in 0...(passwords.length) do
		valid += 1 if (polMap[i][1][0]..polMap[i][1][1]).to_a.include? passwords[i].count(polMap[i][0])
	end
	return valid
end
def part2(passwords, polMap)
	valid = 0
	for i in 0...passwords.length
		valid += 1 if (passwords[i].slice(polMap[i][1][0] - 1) == polMap[i][0]) ^ (passwords[i].slice(polMap[i][1][1] - 1) == polMap[i][0])
	end
	return valid
end
puts part1(passwords, polMap)
puts part2(passwords, polMap)