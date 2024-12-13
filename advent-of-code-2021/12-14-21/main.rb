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
  start = input[0]
  inserts = {}
  for i in 2...input.length
    add = input[i].split(" -> ")
    inserts[add[0]] = add[1]
  end
  10.times do
    newStr = ""
    for i in 0...(start.length - 1)
      pair = start.slice(i) + start.slice(i + 1)
      toAdd = inserts[pair]
      newStr += start.slice(i) + toAdd
    end
    start = newStr + start.slice(-1)
  end
  frequencies = {}
  for i in start.split("")
    (frequencies[i]) ? (frequencies[i] += 1) : (frequencies[i] = 0)
  end
  pairs = {}
  return frequencies.values.max - frequencies.values.min
end

def getFrequencies(pairMap, firstLetter, lastLetter)
  frequencies = {}
  for i in pairMap.keys
    for j in i.split("")
      frequencies[j] ? (frequencies[j] += pairMap[i]) : (frequencies[j] = pairMap[i])
    end
  end
  for i in frequencies.keys
    if not [firstLetter, lastLetter].include? i
      frequencies[i] /= 2
    else
      frequencies[i] = (frequencies[i] + 1) / 2
    end
  end
  return frequencies
end

def part2(input)
  start = input[0]
  inserts = {}
  firstLetter = start.slice(0)
  lastLetter = start.slice(-1)
  for i in 2...input.length
    add = input[i].split(" -> ")
    inserts[add[0]] = add[1]
  end
  pairMap = {}
  for i in 0...(start.length - 1)
    pair = start.slice(i) + start.slice(i + 1)
    pairMap[pair] ? (pairMap[pair] += 1) : (pairMap[pair] = 1)
  end
  40.times do
    newPairMap = {}
    for i in pairMap.keys
      frontPair = i.slice(0) + inserts[i]
      backPair = inserts[i] + i.slice(1)
      (newPairMap[frontPair]) ? (newPairMap[frontPair] += pairMap[i]) : (newPairMap[frontPair] = pairMap[i])
      (newPairMap[backPair]) ? (newPairMap[backPair] += pairMap[i]) : (newPairMap[backPair] = pairMap[i])
    end
    pairMap = newPairMap.clone
  end
  frequencies = getFrequencies(pairMap, firstLetter, lastLetter)
  return (frequencies.values.max - frequencies.values.min)
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
t = Time.now
puts part2(input.clone)
puts Time.now - t