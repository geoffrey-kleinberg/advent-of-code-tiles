fields = []
your = []
other = []
currentArr = 1
File.open("input.txt") do |f|
	f.each do |i|
		if currentArr == 1
			currentArr += 1 and next if i == "\n"
			fields.append(i.strip)
		elsif currentArr == 2
			currentArr += 1 and next if i == "\n"
			next if i == "your ticket:\n"
			your = i.strip.split(",").map { |j| j.to_i }
		else
			next if i == "nearby tickets:\n"
			other.append(i.strip.split(",").map { |j| j.to_i })
		end
	end
end
def getFieldMap(fieldArr)
	fieldMap = fieldArr.inject({}) do |mem, i|
		ranges = i.split(": ")[1].split(" or ").map { |j| ((j.split("-")[0].to_i)..(j.split("-")[1].to_i)).to_a }.flatten
		mem[i.split(":")[0]] = ranges
		mem
	end
	return fieldMap
end
def part1(fields, your, other)
	fields = getFieldMap(fields)
	tser = 0
	validVals = fields.values.flatten
	for i in other
		for j in i
			if not validVals.include? j
				tser += j
			end
		end
	end
	return tser
end
def part2(fields, your, other)
	fields = getFieldMap(fields)
	tser = 0
	validVals = fields.values.flatten
	validTickets = [your]
	for i in other
		valid = true
		for j in i
			if not validVals.include? j
				valid = false
			end
		end
		validTickets.append(i) if valid
	end
	labels = []
	indices = (0...your.length).to_a
	while indices.length > 0
		possible = fields.keys
		for j in validTickets
			for k in possible
				if not fields[k].include? j[indices[0]]
					possible.delete(k)
				end
			end
		end
		if possible.length == 1
			labels[indices[0]] = possible[0]
			fields.delete(possible[0])
		else
			indices.append(indices[0])
		end
		indices = indices.slice(1, indices.length - 1) if indices.length > 0
	end
	return (0...your.length).inject(1) { |mem, i| (labels[i].slice(0, 9) == "departure") ? (mem * your[i]) : mem}
end
puts part1(fields, your, other)
puts part2(fields, your, other)