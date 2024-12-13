fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip.split(" ")
  end
end

def part1(input)
  score = 0
  for i in input
    if i[1] == "X"
      score += 1
      if i[0] == "C"
        score += 6
      elsif i[0] == "A"
        score += 3
      else
        score += 0
      end
    elsif i[1] == "Y"
      score += 2
      if i[0] == "A"
        score += 6
      elsif i[0] == "B"
        score += 3
      else
        score += 0
      end
    elsif i[1] == "Z"
      score += 3
      if i[0] == "B"
        score += 6
      elsif i[0] == "C"
        score += 3
      else
        score += 0
      end
    end
  end
  return score
end

def part2(input)
  score = 0
  for i in input
    if i[1] == "X"
      score += 0
      if i[0] == "C"
        score += 2
      elsif i[0] == "A"
        score += 3
      else
        score += 1
      end
    elsif i[1] == "Y"
      score += 3
      if i[0] == "A"
        score += 1
      elsif i[0] == "B"
        score += 2
      else
        score += 3
      end
    elsif i[1] == "Z"
      score += 6
      if i[0] == "B"
        score += 3
      elsif i[0] == "C"
        score += 1
      else
        score += 2
      end
    end
  end
  return score
end

puts part1(data)
puts part2(data)