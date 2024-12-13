input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i.strip.slice(0, i.length - 1))
	end
end
def makeBasicHash(input)
	bagMap = {}
	for i in input
		iter = i.split(" contain ")
		container = iter[0].split(" ").slice(0, 2).join
		contains = iter[1].split(", ").map { |j| j.split(" ").slice(1, 2).join }
		bagMap[container] = contains
	end
	return bagMap
end
def part1(bagMap)
	queue = ["shinygold"]
	used = []
	while queue.length > 0
		for i in bagMap.keys
			if bagMap[i].include? queue[0] and not used.include? i
				queue.append(i)
				used.append(i)
			end
		end
		queue.delete(queue[0])
	end
	return used.length
end
def makeNumHash(input)
	bagMap = {}
	for i in input
		iter = i.split(" contain ")
		container = iter[0].split(" ").slice(0, 2).join
		if iter[1].slice(0, 2) == "no"
			contains = "NULL"
		else
			contains = iter[1].split(", ").map do |j| 
				[j[0].to_i] + [j.split(" ").slice(1, 2).join]
			end
		end
		bagMap[container] = contains
	end
	return bagMap
end
def part2(numHash)
	queue = ["shinygold"]

	num = -1
	#puts numHash
	while queue.length > 0
		#print numHash[queue[0]]
		#puts
		if numHash[queue[0]] == "NULL"
		else
			for i in numHash[queue[0]]
				for j in 0...i[0]
					queue.append(i[1])
				end
			end
		end
		num += 1
		queue.delete_at(queue.index(queue[0]))
		#print queue
		#puts
	end
	return num
end
puts part1(makeBasicHash(input))
puts part2(makeNumHash(input))