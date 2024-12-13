class String
	def instrSplit
		resultArr = []
		thisStr = nil
		for i in self.split("")
			if not thisStr
				if i == "n" or i == "s"
					thisStr = i
				else
					resultArr << i
				end
			else
				resultArr << thisStr + i
				thisStr = nil
			end
		end
		return resultArr
	end
end
input = []
File.open("input.txt") do |f|
	f.each do |i|
		input << i.instrSplit
	end
end
def part1(input)
	hexes = {}
	for i in input
		x, y = 0, 0
		for j in i
			if j == "e"
				x += 1
			elsif j == "w"
				x -= 1
			elsif j == "se"
				x += 1 if y % 2 != 0
				y -= 1
			elsif j == "sw"
				x -= 1 if y % 2 == 0
				y -= 1
			elsif j == "nw"
				x -= 1 if y % 2 == 0
				y += 1
			elsif j == "ne"
				x += 1 if y % 2 != 0
				y += 1
			end
		end
		if hexes[[x, y]]
			hexes[[x, y]] = nil
		else
			hexes[[x, y]] = true
		end
	end
	yield hexes
	return hexes.values.count { |i| i }
end
def getNeighbors(coords)
	neighbors = [coords]
	neighbors << [coords[0] + 1, coords[1]]
	neighbors << [coords[0] - 1, coords[1]]
	neighbors << [coords[0], coords[1] + 1]
	neighbors << [coords[0], coords[1] - 1]
	if coords[1] % 2 == 0
		neighbors << [coords[0] - 1, coords[1] + 1]
		neighbors << [coords[0] - 1, coords[1] - 1]
	else
		neighbors << [coords[0] + 1, coords[1] + 1]
		neighbors << [coords[0] + 1, coords[1] - 1]
	end
	return neighbors
end
def part2(input)
	hexes = {}
	part1(input) { |i| hexes = i }
	#print hexes
	#puts
	#xMax = hexes.keys.map { |i| hexes[i] ? i[0] : nil}.compact.max
	#xMin = hexes.keys.map { |i| hexes[i] ? i[0] : nil}.compact.min
	#yMax = hexes.keys.map { |i| hexes[i] ? i[1] : nil}.compact.max
	#yMin = hexes.keys.map { |i| hexes[i] ? i[1] : nil}.compact.min
	#puts hexes
	#puts xMax
	#puts xMin
	#puts yMax
	#puts yMin
	days = 100
	for day in 0...days
		check = []
		toSwitch = []
		for i in hexes
			next if not i[1]
			check << getNeighbors(i[0])
		end
		#print check.flatten(1).uniq
		#puts
		for hex in check.flatten(1).uniq
			neighborColors = getNeighbors(hex).map { |i| i == hex ? nil : i}.compact.map { |i| hexes[i] }.count { |i| i }
			if hexes[hex]
				if neighborColors == 0 or neighborColors > 2
					toSwitch << hex
				end
			else
				if neighborColors == 2
					toSwitch << hex
				end
			end
		end
		for i in toSwitch
			if hexes[i]
				hexes[i] = nil
			else
				hexes[i] = true
			end
		end
		#puts "#{day + 1}: #{ct}"
	end
	ct = hexes.values.count { |i| i }
	return ct
end
#print [[[1, 1], [1, 2]], [[3, 4], [1, 2]]].flatten(1).uniq
puts part1(input) { |i| i }
t = Time.now
puts part2(input)
puts Time.now - t