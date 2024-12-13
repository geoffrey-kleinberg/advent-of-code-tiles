input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i.strip)
	end
end
def evalOp(a, b, op)
	if op == "*"
		return a * b
	else
		return a + b
	end
end
def is_int? (str)
	return str.to_i.to_s == str
end
def evalLine(line)
	return line.to_i if is_int? line or line.is_a? Integer
	layers = 0
	past = ""
	outerLayers = []
	outerOps = []
	for i in line.split("")
		if i == "("
			past += "(" if layers != 0
			layers += 1
		elsif i == ")"
			layers -= 1
			past += ")" if layers != 0
			outerLayers.append(past) and past = "" if layers == 0
		elsif layers == 0
			if is_int? i
				outerLayers.append(i)
			elsif i == "*" or i == "+"
				outerOps.append(i)
			end
		else
			past += i
		end
	end
	#print outerLayers
	#puts
	#print outerOps
	#puts
	#puts
	while outerLayers.length > 1
		#print outerLayers
		#puts
		if is_int? outerLayers[0] and is_int? outerLayers[1]
			outerLayers[1] = evalOp(outerLayers[0].to_i, outerLayers[1].to_i, outerOps[0])
		else
			outerLayers[1] = evalOp(evalLine(outerLayers[0]), evalLine(outerLayers[1]), outerOps[0])
		end
		#print outerLayers
		#puts
		#puts
		outerLayers.delete_at(0)
		outerOps.delete_at(0)
	end
	return outerLayers[0].to_i
	#print outerLayers
	#puts
	#print outerOps
	#puts
end
def part1(input)
	input.each.inject(0) do |mem, i| mem + evalLine(i) end
end
def eval2(line)
	return line.to_i if is_int? line or line.is_a? Integer
	layers = 0
	past = ""
	outerLayers = []
	outerOps = []
	for i in line.split("")
		next if i == " "
		if i == "("
			past += "(" if layers != 0
			layers += 1
		elsif i == ")"
			layers -= 1
			past += ")" if layers != 0
			outerLayers.append(past) and past = "" if layers == 0
		elsif layers == 0
			(is_int? i) ? outerLayers.append(i) : outerOps.append(i)
		else
			past += i
		end
	end
	numOuterLayers = []
	for i in outerLayers
		if is_int? i
			numOuterLayers.append(i.to_i)
		else
			numOuterLayers.append(eval2(i))
		end
	end
	i = 0
	while i < numOuterLayers.length - 1
		if outerOps[i] == "+"
			numOuterLayers[i + 1] = numOuterLayers[i] + numOuterLayers[i + 1]
			numOuterLayers.delete_at(i)
			outerOps.delete_at(i)
			i -= 1
		end
		i += 1
	end
	return numOuterLayers.inject(1) { |mem, i| mem * i }
end
def part2(input)
	input.each.inject(0) do |mem, i| mem + eval2(i) end
end
puts part1(input)
puts part2(input)