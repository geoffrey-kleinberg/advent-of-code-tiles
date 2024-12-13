input = []
File.open("input.txt") do |f|
  f.each do |i|
    input.append(i)
  end
end
def binToTen(str)
  sum = 0
  str.split("").reverse.each.with_index do |i, pow|
    sum += i.to_i * (2 ** pow)
  end
  return sum
end
def tenToBin(num, len=36)
  str = ""
  for i in 0...len
    str = (num % 2).to_s + str
    num /= 2
  end
  return str
end
def part1(lines)
  mem = {}
  mask = ""
  for i in lines
    if i.slice(0, 3) == "mem"
      str = tenToBin(i.split(" ")[2].to_i)
      ind = i.split("[")[1].split("]")[0].to_i
      finalStr = ""
      str.split("").each.with_index do |i, j|
        if mask.slice(j) == "X"
          finalStr += str.slice(j)
        else
          finalStr += mask.slice(j)
        end
      end
      mem[ind] = binToTen(finalStr)
    else
      mask = i.split(" ")[2]
    end
  end
  return mem.values.sum
end
def part2(lines)
  mem = {}
  mask = ""
  for i in lines
    if i.slice(0, 3) == "mem"
      str = i.split(" ")[2].to_i
      ind = tenToBin(i.split("[")[1].split("]")[0].to_i)
      finalInds = [""]
      xInd = ""
      ind.split("").each.with_index do |j, ind|
        if mask.slice(ind) == "0"
					#xInd += j
					for k in 0...finalInds.length
						finalInds[k] += j
					end
				elsif mask.slice(ind) == "1"
					for k in 0...finalInds.length
						finalInds[k] += "1"
					end
          #xInd += "1"
				else
					amt = finalInds.length
					for k in 0...amt
						finalInds.append(finalInds[k] + "1")
						finalInds[k] += "0"
					end
          #xInd += "X"
        end
			end
			for j in finalInds
				mem[j] = str
			end
      #addresses = 2 ** xInd.count("X")
			#for j in 0...addresses
			#	address = tenToBin(j, xInd.count("X"))
			#	n = -1
			#	newInd = xInd.split("").map { |k| (k == "X") ? (n += 1 and address.slice(n)) : k }.join
      #  mem[newInd] = str
      #end
    else
      mask = i.split(" ")[2]
    end
  end
  return mem.values.sum
end
puts part1(input)
t = Time.now
puts part2(input)
puts Time.now - t