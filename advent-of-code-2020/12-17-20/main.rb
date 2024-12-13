input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i)
	end
end
def hashToHash(input)
	outHash = {}
	for x in 0...input.length
		for y in 0...input[x].length
			if input[x].slice(y) == "#"
				outHash[[x, y, 0]] = true
			end
		end
	end
	return outHash
end
def hashToHash4D(input)
	outHash = {}
	for x in 0...input.length
		for y in 0...input[x].length
			if input[x].slice(y) == "#"
				outHash[[x, y, 0, 0]] = true
			end
		end
	end
	return outHash
end
def part1(input)
	xMax = input.length
	yMax = input[0].length
	zMax = 1
	oldHash = hashToHash(input)
	for iter in 1..6
		newHash = {}
		for x in (-1 * iter)..xMax
			for y in (-1 * iter)..yMax
				for z in (-1 * iter)..zMax
					neighbors = []
					for i in -1..1
						for j in -1..1
							for k in -1..1
								neighbors.append(oldHash[[x + i, y + j, z + k]]) if not (i == 0 and j == 0 and k == 0)
							end
						end
					end
					neighbors = neighbors.compact
					if oldHash[[x, y, z]] and [2, 3].include? neighbors.length
						newHash[[x, y, z]] = true
					end
					if not oldHash[[x, y, z]] and neighbors.length == 3
						newHash[[x, y, z]] = true
					end
				end
			end
		end
		xMax += 1
		yMax += 1
		zMax += 1
		oldHash = newHash.clone
	end
	return newHash.values.compact.length
end
def part2(input)
	xMax = input.length
	yMax = input[0].length
	zMax = 1
	wMax = 1
	oldHash = hashToHash4D(input)
	for iter in 1..6
		newHash = {}
		for x in (-1 * iter)..xMax
			for y in (-1 * iter)..yMax
				for z in (-1 * iter)..zMax
					for w in (-1 * iter)..wMax
						neighbors = []
						for i in -1..1
							for j in -1..1
								for k in -1..1
									for l in -1..1
										neighbors.append(oldHash[[x + i, y + j, z + k, w + l]]) if not (i == 0 and j == 0 and k == 0 and l == 0)
									end
								end
							end
						end
						neighbors = neighbors.compact
						if oldHash[[x, y, z, w]] and [2, 3].include? neighbors.length
							newHash[[x, y, z, w]] = true
						end
						if not oldHash[[x, y, z, w]] and neighbors.length == 3
							newHash[[x, y, z, w]] = true
						end
					end
				end
			end
		end
		xMax += 1
		yMax += 1
		zMax += 1
		wMax += 1
		oldHash = newHash.clone
		puts iter
	end
	return newHash.values.compact.length
end
=begin
def hashToHashND(input, dim)
	outHash = {}
	for x in 0...input.length
		for y in 0...input[x].length
			if input[x].slice(y) == "#"
				key = [x, y] + ([0].clone * (dim - 2))
				outHash[key]  = true
			end
		end
	end
	return outHash
end
=end
puts part1(input)
t = Time.now
puts part2(input)
puts Time.now - t
