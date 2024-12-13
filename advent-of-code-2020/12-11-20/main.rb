input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i.strip.split(""))
	end
end
puts
def changeState(seats)
	switchList = []
	for i in 0...seats.length
		for j in 0...seats[i].length
			next if seats[i][j] == "."
			occupied = 0
			if i == 0
				if j == 0
					occupied += [seats[0][1], seats[1][1], seats[1][0]].count("#")
				else
					occupied += [seats[0][j - 1], seats[0][j + 1], seats[1][j - 1], seats[1][j], seats[1][j + 1]].count("#")
				end
			elsif j == 0
				if i == seats.length - 1
					occupied += [seats[i - 1][j], seats[i - 1][j + 1], seats[i][j + 1]].count("#")
				else
					occupied += [seats[i - 1][0], seats[i - 1][1], seats[i][1], seats[i + 1][0], seats[i + 1][1]].count("#")
				end
			elsif i == seats.length - 1
				occupied += [seats[i][j - 1], seats[i][j + 1], seats[i - 1][j - 1], seats[i - 1][j], seats[i - 1][j + 1]].count("#")
			else
				occupied += [seats[i - 1][j - 1], seats[i - 1][j], seats[i - 1][j + 1], seats[i][j - 1], seats[i][j+ 1], seats[i + 1][j - 1], seats[i + 1][j], seats[i + 1][j + 1]].count("#")
			end
			if seats[i][j] == "L" and occupied == 0
				switchList.append([i, j])
			elsif seats[i][j] == "#" and occupied >= 4
				switchList.append([i, j])
			end
		end
	end
	for i in switchList
		(seats[i[0]][i[1]] == "L") ? (seats[i[0]][i[1]] = "#") : (seats[i[0]][i[1]] = "L")
	end
	return seats
end
def firstSeen(i, j, seats)
	seen = []
	#left
	jl = j - 1
	while jl >= 0
		look = seats[i][jl]
		jl -= 1
		next if look == "."
		seen.append(look)
		break
	end
	#up
	iu = i - 1
	while iu >= 0
		look = seats[iu][j]
		iu -= 1
		next if look == "."
		seen.append(look)
		break
	end
	#down
	id = i + 1
	while id < seats.length
		look = seats[id][j]
		id += 1
		next if look == "."
		seen.append(look)
		break
	end
	#right
	jr = j + 1
	while jr < seats[i].length
		look = seats[i][jr]
		jr += 1
		next if look == "."
		seen.append(look)
		break
	end
	#up-left
	iu = i - 1
	jl = j - 1
	while jl >= 0 and iu >= 0
		look = seats[iu][jl]
		iu -= 1
		jl -= 1
		next if look == "."
		seen.append(look)
		break
	end
	#down-left
	id = i + 1
	jl = j - 1
	while jl >= 0 and id < seats.length
		look = seats[id][jl]
		id += 1
		jl -= 1
		next if look == "."
		seen.append(look)
		break
	end
	#up-right
	iu = i - 1
	jr = j + 1
	while jl < seats[i].length and iu >= 0
		look = seats[iu][jr]
		iu -= 1
		jr += 1
		next if look == "."
		seen.append(look)
		break
	end
	#down-right
	id = i + 1
	jr = j + 1
	while jr < seats[i].length and id < seats.length
		look = seats[id][jr]
		id += 1
		jr += 1
		next if look == "."
		seen.append(look)
		break
	end
	return seen
end
def change2(seats)
	toChange = []
	for i in 0...seats.length
		for j in 0...seats[i].length
			next if seats[i][j] == "."
			visible = firstSeen(i, j, seats)
			#puts "hi"
			occupied = visible.count("#")
			if seats[i][j] == "L" and occupied == 0
				toChange.append([i, j])
			elsif seats[i][j] == "#" and occupied >= 5
				toChange.append([i, j])
			end
		end
	end
	for i in toChange
		if seats[i[0]][i[1]] == "L"
			seats[i[0]][i[1]] = "#"
		else
			seats[i[0]][i[1]] = "L"
		end
	end
	return seats
end
def part1(input)
	oldSeats = input
	newSeats = changeState(oldSeats.map { |i| i.map { |j| j } })
	while newSeats != oldSeats
		oldSeats = newSeats
		newSeats = changeState(oldSeats.map { |i| i.map { |j| j } })
	end
	return newSeats.flatten.count("#")
end
def part2(input)
	oldSeats = input
	newSeats = change2(oldSeats.map { |i| i.map { |j| j } })
	while newSeats != oldSeats
		oldSeats = newSeats
		newSeats = change2(oldSeats.map { |i| i.map { |j| j } })
	end
	return newSeats.flatten.count("#")
end
puts part1(input)
puts part2(input)
#change2(input).each do |i| puts i.join end
#print firstSeen(7, 9, input)