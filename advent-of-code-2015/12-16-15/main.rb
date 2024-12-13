file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getCounts(line)
  counts = {}
  splitLine = line.split(" ")
  for i in 2...(splitLine.length)
    counts[splitLine[i].chop] = splitLine[i + 1].to_i
  end
  return counts
end

def part1(lines)
  known = {"children" => 3, "cats" => 7, "samoyeds" => 2, "pomeranians" => 3,
    "akitas" => 0, "vizslas" => 0, "goldfish" => 5, "trees" => 3, "cars" => 2,
    "perfumes" => 1}
  sue = 1
  for i in lines
    counts = getCounts(i)
    match = true
    for j in known.keys
      if counts[j] and counts[j] != known[j]
        match = false
        break
      end
    end
    puts sue if match
    sue += 1
  end
  return 0
end

def part2(lines)
  known = {"children" => 3, "cats" => 7, "samoyeds" => 2, "pomeranians" => 3,
    "akitas" => 0, "vizslas" => 0, "goldfish" => 5, "trees" => 3, "cars" => 2,
    "perfumes" => 1}
  sue = 1
  for i in lines
    counts = getCounts(i)
    match = true
    for j in known.keys
      if ["cats", "trees"].include? j
        if counts[j] and counts[j] <= known[j]
          match = false
          break
        end
      elsif ["pomeranians", "goldfish"].include? j
        if counts[j] and counts[j] >= known[j]
          match = false
          break
        end
      else
        if counts[j] and counts[j] != known[j]
          match = false
          break
        end
      end
    end
    puts sue if match
    sue += 1
  end
  return 0
end

#puts part1(lines)
puts part2(lines)