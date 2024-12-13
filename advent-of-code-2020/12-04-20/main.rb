passportLines = []
nextL = ""
File.open("input.txt") do |f|
	f.each do |l|
		if l != "\n"
			nextL += " " if nextL.length != 0
			nextL += l.strip
		else
			passportLines.append(nextL)
			nextL = ""
		end
	end
	passportLines.append(nextL)
end
def part1(pLines)
	valid = 0
	for i in pLines
		pArr = i.split(" ")
		next if pArr.length < 7
		valid += 1 and next if pArr.length == 8
		keys = pArr.map { |i| i.slice(0, 3) }
		(keys.include? "cid") ? (next) : (valid += 1)
	end
	return valid
end
def checkValidFields(pArr)
	return false if pArr.length < 7
	return true if pArr.length == 8
	keys = pArr.map { |i| i.slice(0, 3) }
	(keys.include? "cid") ? (return false) : (return true)
end
def fitsAlpha(string, alpha)
	for i in string.split("")
		if not alpha.include? i
			return false
		end
	end
	return true
end
def part2(pLines)
	valid = 0
	for i in pLines
		pArr = i.split(" ")
		next if not checkValidFields(pArr)
		pHash = pArr.inject({}) do |memo, val|
			memo[val.split(":")[0]] = val.split(":")[1]
			memo
		end
		next if pHash["byr"].to_i < 1920 or pHash["byr"].to_i > 2002
		next if pHash["iyr"].to_i < 2010 or pHash["iyr"].to_i > 2020
		next if pHash["eyr"].to_i < 2020 or pHash["eyr"].to_i > 2030
		hUnit = pHash["hgt"].slice(-2, 2)
		if hUnit == "in"
			next if pHash["hgt"].slice(0, pHash["hgt"].length - 2).to_i < 59 or pHash["hgt"].slice(0, pHash["hgt"].length - 2).to_i > 76
		elsif hUnit == "cm"
			next if pHash["hgt"].slice(0, pHash["hgt"].length - 2).to_i < 150 or pHash["hgt"].slice(0, pHash["hgt"].length - 2).to_i > 193
		else
			next
		end
		next if not pHash["hcl"].slice(0) == "#"
		next if not (pHash["hcl"].length == 7 and fitsAlpha(pHash["hcl"].slice(1, 6), ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]))
		next if not (fitsAlpha(pHash["pid"], ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]) and pHash["pid"].length == 9)
		next if not ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? pHash["ecl"]
		valid += 1
	end
	return valid
end
puts part1(passportLines)
puts part2(passportLines)