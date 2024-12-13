cardKey = 5290733
doorKey = 15231938
def part1(cKey, dKey)
	cLoop = 0
	cSubj = 7
	cVal = 1
	until cVal == cKey
		cVal *= cSubj
		cVal %= 20201227
		cLoop += 1
	end
	puts "ok"
	dLoop = 0
	dSubj = 7
	dVal = 1
	until dVal == dKey
		dVal *= dSubj
		dVal %= 20201227
		dLoop += 1
	end
	puts "ok"
	dSubj = dKey
	dVal = 1
	for i in 0...cLoop
		dVal *= dSubj
		dVal %= 20201227
	end
	return dVal
	puts dLoop
	puts cLoop
end
puts part1(cardKey, doorKey)