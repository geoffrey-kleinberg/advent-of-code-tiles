input = []
File.open("input.txt") do |f|
	first = true
	thisArr = []
	f.each do |i|
		if first
			thisArr.append(i.strip.slice(5, 4))
			first = false
		elsif i == "\n"
			input.append(thisArr)
			thisArr = []
			first = true
		else
			thisArr.append(i.strip)
		end
	end
	input.append(thisArr)
end
def arrToMap(inArr)
	return inArr.inject({}) do |mem, i| 
		mem[i[0].to_i] = i.slice(1, i.length - 1)
		mem
	end
end
def getEdges(id, imgHash)
	edges = []
	edges.append(imgHash[id][0])
	edges.append(imgHash[id][imgHash[id].length - 1])
	edges.append(imgHash[id].map { |i| i.slice(0) }.join)
	edges.append(imgHash[id].map { |i| i.slice(i.length - 1) }.join)
	return edges
end
def getUMHash(borderHash, allBorders)
	unmatchedHash = {}
	for i in borderHash.keys
		unmatched = 0
		for j in borderHash[i]
			matches = allBorders.count(j) + allBorders.count(j.reverse)
			unmatched += 1 if matches == 1
		end
		unmatchedHash[i] = unmatched
	end
	return unmatchedHash
end
def part1(input)
	imgHash = arrToMap(input)
	borderHash = {}
	for i in imgHash.keys
		borderHash[i] = getEdges(i, imgHash)
	end
	allBorders = borderHash.values.flatten
	unmatchedHash = getUMHash(borderHash, allBorders)
	return unmatchedHash.keys.inject(1) { |mem, i| unmatchedHash[i] == 2 ? mem * i : mem}
end
def orient(square, oId)
	if oId == 0
		return square
	elsif oId == 1
		return square.reverse
	elsif oId == 2
		return square.map { |i| i.reverse }
	elsif oId == 3
		newSquare = []
		for i in 0...square[0].length
			thisCol = square.map { |j| j.slice(i) }.join.reverse
			newSquare.append(thisCol)
		end
		return newSquare
	elsif oId == 4
		return square.reverse.map { |i| i.reverse }
	elsif oId == 5
		newSquare = []
		for i in 1..square[0].length
			thisCol = square.map { |j| j.slice(square[0].length - i) }.join
			newSquare.append(thisCol)
		end
		return newSquare
	elsif oId == 6
		return orient(orient(square, 3), 1)
	elsif oId == 7
		return orient(orient(square, 3), 2)
	elsif oId == 8
		return orient(orient(square, 5), 1)
	elsif oId == 9
		return orient(orient(square, 5), 2)
	end
end
def makePlaceHash(input)
=begin
	#2D arr of [id, orientation]
	#orientations:
	0: unchanged
	1: flipped vertically
	2: flipped horizontally
	3: rotated 90 clockwise
	4: rotated 180
	5: rotated 90 CCW
=end
	imgHash = arrToMap(input)
	borderHash = {}
	for i in imgHash.keys
		borderHash[i] = getEdges(i, imgHash)
	end
=begin
	borderMatchHash = {}
	for i in borderHash.keys
		thisB = borderHash[i]
		matches = []
		for k in thisB
			for j in borderHash.keys
				next if j == i
				if borderHash[j].include? k or borderHash[j].include? k.reverse
					matches.append([j])
	#borderHash order: top, bottom, left, right
	umHash = getUMHash(borderHash, allBorders)
	corners = umHash.keys.map { |i| umHash[i] == 2 ? i : nil }.compact
=begin
	for i in corners
		itsEdges = borderHash[i]
		pattern = []
		for j in itsEdges
			if allBorders.count(j) + allBorders.count(j.reverse) == 1
				pattern.append("outside")
			elsif allBorders.count(j) ==
	edges = umHash.keys.map { |i| umHash[i] == 1 ? i : nil }.compact
	centers = umHash.keys.map { |i| umHash[i] == 0 ? i : nil }.compact
=end
	#key is relative coords
	#value is id and orientation
	placeHash = {}
	ids = borderHash.keys
	#print ids
	#puts
	placeHash[[0, 0]] = [ids[0], 0]
	ids.delete(ids[0])
	while ids.length > 0
		placed = false
		addOn = ids[0]
		for i in placeHash.keys
			baseSqr = orient(imgHash[placeHash[i][0]], placeHash[i][1])
			#for all that are placed
			for side in 0...4
				for ori in 0...10
					addSqr = orient(imgHash[addOn], ori)
					if side == 0
						topBase = baseSqr[0]
						bottomSide = addSqr[addSqr.length - 1]
						if topBase == bottomSide
							placed = true
							placeHash[[i[0], i[1] - 1]] = [addOn, ori]
						end
					elsif side == 1
						bottomBase = baseSqr[addSqr.length - 1]
						topSide = addSqr[0]
						if topSide == bottomBase
							placed = true
							placeHash[[i[0], i[1] + 1]] = [addOn, ori]
						end
					elsif side == 2
						leftBase = baseSqr.map { |j| j.slice(0) }.join
						rightSide = addSqr.map { |j| j.slice(j.length - 1) }.join
						if leftBase == rightSide
							placed = true
							placeHash[[i[0] - 1, i[1]]] = [addOn, ori]
						end
					elsif side == 3
						leftSide = addSqr.map { |j| j.slice(0) }.join
						rightBase = baseSqr.map { |j| j.slice(j.length - 1) }.join
						#if i == [0, 0] and ids.length == 1
						#	puts leftSide
						#	puts rightBase
						#	puts
						#end
						if leftSide == rightBase
							placed = true
							placeHash[[i[0] + 1, i[1]]] = [addOn, ori]
						end
					end
					break if placed
					#does addOn fit in that orientation with side
					#if so, put it in placeHash and delete it from borderHash
					#if not, add it back onto ids
				end
				break if placed
			end
			break if placed
		end
		#break if ids.length == 1
		ids.append(ids[0]) if not placed
		ids.delete_at(0)
		#puts ids.length
		#print placeHash
		#puts
		#print ids if ids.length == 1
		#puts
	end
	#print ids
	#puts
	return placeHash
end
def trimEdges(imgHash)
	newHash = {}
	for i in imgHash.keys
		newArr = imgHash[i].slice(1, imgHash[i].length - 2)
		newArr = newArr.map { |j| j.slice(1, j.length - 2) }
		newHash[i] = newArr
	end
	return newHash
end
def makeImage(placeHash, imgHash, input)
	l = Math.sqrt(input.length).to_i
	imgIDArr = []
	l.times do imgIDArr.append([]) end
	addX = placeHash.keys.map { |i| i[0] }.min * -1
	addY = placeHash.keys.map { |i| i[1] }.min * -1
	for i in placeHash.keys
		imgIDArr[i[1] + addY][i[0] + addX] = placeHash[[i[0], i[1]]]
	end
	imgHash = trimEdges(imgHash)
	imgArr = []
	l.times do imgArr.append([]) end
	for i in 0...l
		for j in 0...l
			imgArr[i][j] = orient(imgHash[imgIDArr[i][j][0]], imgIDArr[i][j][1])
		end
	end
	finalImg = []
	for i in 0...l
		for j in 0...(imgArr[0][0].length)
			nextLine = ""
			for k in 0...l
				nextLine += imgArr[i][k][j]
			end
			finalImg.append(nextLine)
		end
	end

	#print imgIDArr
	#puts
	#print imgArr
	#puts
	return finalImg
end
def part2(input)
	imgHash = arrToMap(input)
	puts "got imgHash"
	borderHash = {}
	for i in imgHash.keys
		borderHash[i] = getEdges(i, imgHash)
	end
	puts "got borderHash"
	placeHash = makePlaceHash(input)
	puts "got placeHash"
	image = makeImage(placeHash, imgHash, input)
	#puts image
	puts "got image"
	seaMonsterLength = 20
	seaMonsterHeight = 3
	for ori in 0...10
		monsters = 0
		look = orient(image, ori)
		for i in 0...(look.length - (seaMonsterHeight - 1))
			for j in 0...(look[0].length - (seaMonsterLength - 1))
				monsterLocs = [look[i][j + 18], look[i + 1][j], look[i + 1][j + 5], look[i + 1][j + 6], look[i + 1][j + 11], look[i + 1][j + 12], look[i + 1][j + 17], look[i + 1][j + 18], look[i + 1][j + 19], look[i + 2][j + 1], look[i + 2][j + 4], look[i + 2][j + 7], look[i + 2][j + 10], look[i + 2][j + 13], look[i + 2][j + 16]]
				if not monsterLocs.include? "."
					monsters += 1
				end
			end
		end
		break if not monsters == 0
	end
	return image.join.count("#") - monsters * 15
end
puts part1(input)
t = Time.now
puts part2(input)
puts Time.now - t