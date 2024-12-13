input = nil
File.open("input.txt") do |f|
	f.each do |i|
		input = i.strip.split("").map { |j| j.to_i }
	end
end
def part1(input)
	currInd = 0
	currCup = input[currInd]
	for move in 0...100
		#print input
		#puts
		#puts currCup
		pickedUp = input.slice(currInd + 1, 3)
		beginning = 0
		while not pickedUp or pickedUp.length < 3
			pickedUp = [] if not pickedUp
			pickedUp << input[beginning]
			beginning += 1
		end
		#print pickedUp
		#puts
		for i in pickedUp
			input.delete(i)
		end
		destinationCup = currCup - 1
		if destinationCup < input.min
			destinationCup = input.max
		end
		while pickedUp.include? destinationCup
			destinationCup -= 1
			if destinationCup < input.min
				destinationCup = input.max
			end
		end
		#puts destinationCup
		dInd = (input.index(destinationCup)) % input.length
		input = input.slice(0, dInd + 1) + pickedUp + input.slice(dInd + 1, input.length - (dInd + 1))
		currInd = (input.index(currCup) + 1) % input.length
		currCup = input[currInd]
	end
	#print input
	#puts
	input = input.slice(input.index(1) + 1, input.length - (input.index(1))) + input.slice(0, input.index(1))
	#print input
	#puts
	return input.map { |i| i.to_i }.join
end
def part2(input)
=begin
	currInd = 0
	currCup = input[currInd]
	for move in 0...10
		print input
		puts
		puts currCup
		pickedUp = input.slice(currInd + 1, 3)
		beginning = 0
		while not pickedUp or pickedUp.length < 3
			pickedUp = [] if not pickedUp
			pickedUp << input[beginning]
			beginning += 1
		end
		print pickedUp
		puts
		a = input.length
		for i in 1..3
			nextDel = currInd + 1
			nextDel = 0 if nextDel >= input.length
			input.delete_at(nextDel)
		end
		currInd = (currInd + 4) % (input.length + 3)
		destinationCup = currCup - 1
		if destinationCup < input.min
			destinationCup = input.max
		end
		while pickedUp.include? destinationCup
			destinationCup -= 1
			if destinationCup < input.min
				destinationCup = input.max
			end
		end
		puts destinationCup
		dInd = (input.index(destinationCup)) % input.length
		input = input.slice(0, dInd + 1) + pickedUp + input.slice(dInd + 1, input.length - (dInd + 1))
		currCup = input[currInd]
		puts move if move % 1000000 == 0
		puts
		puts
	end
	print input
	puts
	oneInd = input.index(1)
	nextInd = (oneInd + 1) % input.length
	otherInd = (oneInd + 2) % input.length
	return input[nextInd] * input[otherInd]
=end
	order = {}
	first = input[0]
	for i in 0...(input.length - 1)
		order[input[i]] = input[i + 1]
	end
	order[input[input.length - 1]] = input.max + 1
	maxNum = 1000000
	for i in (input.max + 1)...maxNum
		order[i] = i + 1
	end
	order[maxNum] = first
	#comment this out for actual test
	#order[7] = 3
	#order.delete(10)
	#end comment out
	moves = 10000000
	#print order
	#puts
	for move in 0...moves
		#puts first
		nextThree = [order[first]]
		for i in 0...2
			nextThree << order[nextThree[i]]
		end
		#print nextThree
		#puts
		destination = first - 1
		if destination < 1
			destination = maxNum
		end
		while nextThree.include? destination
			destination -= 1
			if destination < 1
				destination = maxNum
			end
		end
		nextFirst = order[nextThree[2]]
		
		order[first] = order[nextThree[2]]
		order[nextThree[2]] = order[destination]
		order[destination] = nextThree[0]
		#puts
		first = nextFirst
		#print order
		#puts
		#puts move if move % 10000 == 0
	end
	return order[1] * order[order[1]]
end
puts part1(input.clone)
t = Time.now
puts part2(input)
puts (Time.now - t)