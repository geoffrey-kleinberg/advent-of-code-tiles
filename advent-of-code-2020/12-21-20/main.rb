input = []
File.open("input.txt") do |f|
	f.each do |i|
		input << i.strip
	end
end
def parsePart1(input)
	resultHash = {}
	for i in input
		ingredients = i.split(" (contains ")[0].split(" ")
		aller = i.split(" (contains ")[1]
		allergens = aller.slice(0, aller.length - 1).split(", ")
		for j in allergens
			(resultHash[j]) ? resultHash[j].append(ingredients) : resultHash[j] = [ingredients]
		end
	end
	return resultHash
end
def appearsInAll(lists)
	return lists[0] if lists.length == 1
	result = []
	for i in lists[1]
		if lists[0].include? i
			result << i
		end
	end
	for i in 2...lists.length
		j = 0
		while j < result.length
			(lists[i].include? result[j]) ? j += 1 : result.delete_at(j)
		end
	end
	return result
end
def part1(input)
	allHash = parsePart1(input)
	allergens = allHash.keys
	possibleIngreds = {}
	for i in allergens
		possibleIngreds[i] = appearsInAll(allHash[i])
	end
	finalHash = {}
	while allergens.length > 0
		allergen = allergens[0]
		thisList = possibleIngreds[allergen].clone
		if thisList.length == 1
			finalHash[allergen] = thisList[0]
			possibleIngreds.delete(allergen)
			for i in possibleIngreds.keys
				possibleIngreds[i].delete(thisList[0])
			end
		else
			if thisList.length == 1
				finalHash[allergen] = thisList[0]
				possibleIngreds.delete(allergen)
				for i in possibleIngreds.keys
					possibleIngreds[i].delete(thisList[0])
				end
			else
				allergens << allergen
			end
		end
		allergens.delete_at(0)
	end
	yield finalHash
	allIngredients = input.map { |i| i.split(" (contains ")[0].split(" ")}.flatten
	return allIngredients.count { |i| not finalHash.values.flatten.include? i }
end
def part2(input)
	part1(input) { |i| return i.keys.sort.map { |j| i[j] }.join(",") }
end
puts part1(input) { |i| i }
puts part2(input)