fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def part1(input)
  letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  score = 0
  for i in input
    letter = nil
    len = i.length
    half = len / 2
    first = i.slice(0, half)
    second = i.slice(half, half)
    #puts first
    #puts second
    for j in first.split("")
      if second.include? j
        letter = j
      end
    end
    score += letters.split("").index(letter) + 1
    #puts letter
    #puts letters.split("").index(letter) + 1
  end
  return score
end

def part2(input)
  letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  score = 0
  for i in 0...(input.length / 3)
    lineOne = input[3 * i]
    lineTwo = input[(3 * i) + 1]
    lineThree = input[(3 * i) + 2]
    oneAndTwo = []
    for j in lineOne.split("")
      if lineTwo.include? j
        oneAndTwo << j
      end
    end
    for j in lineThree.split("")
      if oneAndTwo.include? j
        score += letters.split("").index(j) + 1
        break
      end
    end
  end
  return score
end

puts part1(data)
puts part2(data)