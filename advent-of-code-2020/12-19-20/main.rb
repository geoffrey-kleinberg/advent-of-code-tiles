input = {}
lines = []
File.open("input.txt") do |f|
	first = true
	f.each do |i|
		first = false or next if i == "\n"
		input[i.split(":")[0].to_i] = i.strip.split(": ")[1].split(" | ").map { |j| j.split(" ") } if first
		lines << i.strip if not first
	end
end
def follow(num, rules, known)
	return known[num] if known[num]
	valStrs = []
	for i in rules[num]
		valSets = []
		thisVal = []
		for j in i
			if j == "\"a\"" or j == "\"b\""
				yield [j.slice(1)]
				return [j.slice(1)]
			else
				valSets << follow(j.to_i, rules, known) { |k| known[j.to_i] = k} 
			end
		end
		poss = valSets.inject(1) { |mem, i| mem * i.length }
		for i in 0...poss
			thisVal << ""
		end
		rep = 1
		for i in valSets
			add = poss / i.length
			ind = 0
			for l in 0...rep
				for k in i
					for j in 0...add
						thisVal[ind] += k
						ind += 1
					end
				end
			end
			rep *= i.length
			poss /= i.length
		end
		valStrs << thisVal
	end
	yield valStrs.flatten
	return valStrs.flatten
end
def part1(keys, lines)
	valid = follow(0, keys, {}) { |i| i }
	return lines.inject(0) { |mem, i| (valid.include? i) ? mem + 1 : mem}
end
def part2(keys, lines)
	#keys[8] << ["42", "8"]
	#keys[11] << ["42", "11", "31"]
	match42 = follow(42, keys, {}) { |i| i}
	match31 = follow(31, keys, {}) { |i| i}
	len = match42[0].length
	valid = 0
	for i in lines
		segs = i.length / len
		consec42s = 0
		consec31s = 0
		going42 = true
		going31 = true
		for place in 0...segs
			if going42 and match42.include? i.slice(place * len, len)
				consec42s += 1
			else
				going42 = false
			end
			if going31 and match31.include? i.slice(i.length - ((place + 1) * len), len)
				consec31s += 1
			else
				going31 = false
			end
		end
		overLap = consec31s + consec42s - segs
		#puts overLap
		if (consec31s - overLap) < consec42s and consec31s + consec42s >= segs and consec31s > 0 and consec42s > 0
			valid += 1
			#puts i
		end
		#puts i
		#puts consec42s
		#puts consec31s
		#puts segs
		#puts overLap
		#puts valid
		#puts
		#puts consec42s
		#puts consec31s
	end
	#print match42.include? "bbbab"
	#puts
	#print match31.include? "bbbbb"
	#puts
	return valid
end
puts part1(input, lines)
puts part2(input, lines)