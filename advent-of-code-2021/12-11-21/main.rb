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

def getNeighbors(x, y, maxX, maxY)
  neighbors = []
  for i in -1..1
    for j in -1..1
      neighbors << [x + i, y + j]
    end
  end
  neighbors.delete_if { |i|
    i.any? { |j|
      j < 0
    }
  }
  neighbors.delete_if { |i|
    i[0] >= maxX or i[1] >= maxY
  }
  neighbors.delete([x, y])
  return neighbors
end

def step(octopi)
  flashes = 0
  flashed = []
  for i in 0...octopi.length
    for j in 0...octopi[i].length
      octopi[i][j] += 1
    end
  end
  while octopi.flatten.any? { |power| power >= 10 }
    for i in 0...octopi.length
      len = octopi[i].length
      for j in 0...len
        if octopi[i][j] >= 10
          flashes += 1
          for k in getNeighbors(i, j, octopi.length, len)
            octopi[k[0]][k[1]] += 1
          end
          octopi[i][j] = 0
          flashed << [i, j]
        end
      end
    end
  end
  for i in flashed
    octopi[i[0]][i[1]] = 0
  end
  yield flashes
  return octopi
end

def part1(input)
  flashes = 0
  input = input.map { |i| i.split("").map { |j| j.to_i }}
  input.each do |i|
  #  puts i.join
  end
  100.times do |rep|
    input = step(input) { |i|
      flashes += i
    }
    #puts
    input.each do |i|
    #  puts i.join
    end
    #break if rep == 1
  end
  return flashes
end

def part2(input)
  input = input.map { |i| i.split("").map { |j| j.to_i }}
  rep = 0
  while not input.all? { |i| i.all? { |j| j == 0} } do
    input = step(input) { |i| i }
    rep += 1
    #puts rep
    #break if rep == 195
  end
  return rep
end

puts part1(sinput.clone)
puts part1(input.clone)

#puts

puts part2(sinput.clone)
puts part2(input.clone)