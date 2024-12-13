def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def part1(input)
  digits = input.map { |i| i.split(" | ")[1].split(" ") }
  #print digits
  #puts
  total = 0
  for i in digits
    for j in i
      total += 1 if [2, 3, 4, 7].include? j.length
    end
  end
  return total
end

require 'set'

def decodeDigits(digits)
  key = {}
  one = digits.clone.delete_if { |i| i.length != 2 }[0]
  seven = digits.clone.delete_if { |i| i.length != 3 }[0]
  eight = digits.clone.delete_if { |i| i.length != 7 }[0]
  key[seven.split("").delete_if { |i| one.include? i }[0]] = "a"
  for i in 'a'..'g'
    digitCount = digits.join.count(i)
    if digitCount == 9
      key[i] = 'f'
    end
    if digitCount == 6
      key[i] = 'b'
    end
    if digitCount == 4
      key[i] = 'e'
    end
    if digitCount == 8 and not key.has_key? (i)
      key[i] = 'c'
    end
  end
  remaining = ('a'..'g').to_a.delete_if { |i| key.has_key? i }
  zero = ''
  for i in digits.clone.delete_if { |i| i.length != 6 }
    if not remaining.all? { |j| i.include? j }
      zero = i
    end
  end
  middle = eight.split("").delete_if { |i| zero.include? i}[0]
  key[middle] = "d"
  remaining.delete(middle)
  key[remaining[0]] = 'g'
  return key
end

def convertToNum(letters, encoding)
  decoder = { 
    Set['a', 'b', 'c', 'e', 'f', 'g'] => 0,
    Set['c', 'f'] => 1,
    Set['a', 'c', 'd', 'e', 'g'] => 2,
    Set['a', 'c', 'd', 'f', 'g'] => 3,
    Set['b', 'c', 'd', 'f'] => 4,
    Set['a', 'b', 'd', 'f', 'g'] => 5,
    Set['a', 'b', 'd', 'e', 'f', 'g'] => 6,
    Set['a', 'f', 'c'] => 7,
    Set['a', 'b', 'c', 'd', 'e', 'f', 'g'] => 8,
    Set['a', 'b', 'c', 'd', 'f', 'g'] => 9
  }
  newLetters = Set[]
  for i in letters.split("")
    newLetters.add(encoding[i])
  end
  return decoder[newLetters]
end

def part2(input)
  total = 0
  for line in input
    digits = line.split(" | ")[0].split(" ")
    output = line.split(" | ")[1].split(" ")
    encoding = decodeDigits(digits)
    num = ""
    for i in output
      nextDigit = convertToNum(i, encoding)
      num += nextDigit.to_s
    end
    total += num.to_i
  end
  return total
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)