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
  nice = 0
  for line in input
    lastLetter = nil
    vowels = 0
    doubleLetter = false
    containsBad = false
    for i in line.split("")
      if ["a", "e", "i", "o", "u"].include? i
        vowels += 1
      end
      if i == lastLetter
        doubleLetter = true
      end
      if lastLetter and ["ab", "cd", "pq", "xy"].include? (lastLetter + i)
        containsBad = true
        break
      end
      lastLetter = i
    end
    if not (containsBad) and doubleLetter and vowels >= 3
      nice += 1
    end
  end
  return nice
end

def part2(input)
  nice = 0
  for line in input
    pairs = []
    lastLetter = nil
    secondLastLetter = nil
    hasRepeatPair = false
    hasRepeatBetween = false
    for i in line.split("")
      if i == secondLastLetter
        hasRepeatBetween = true
      end
      if lastLetter
        pair = lastLetter + i
        prevPairs = pairs.slice(0, pairs.length - 1)
        if prevPairs and prevPairs.include? pair
          hasRepeatPair = true
        end
        pairs << pair
      end
      if lastLetter == secondLastLetter and i == lastLetter
        puts line
      end
      secondLastLetter = lastLetter
      lastLetter = i
    end
    if hasRepeatPair and hasRepeatBetween
      nice += 1
    end
  end
  return nice
end

#puts part1(sinput.clone)
#puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)