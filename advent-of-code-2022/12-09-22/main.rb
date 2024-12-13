require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def updateH(hLoc, dir)
  newH = hLoc.clone
  if dir == "R"
    newH[0] += 1
  elsif dir == "L"
    newH[0] -= 1
  elsif dir == "U"
    newH[1] += 1
  else
    newH[1] -= 1
  end
  return newH
end

def sign(x)
  if x < 0
    return -1
  elsif x > 0
    return 1
  else
    return 0
  end
end

def adjacent(hLoc, tLoc)
  return ((hLoc[0] - tLoc[0]).abs <= 1 and (hLoc[1] - tLoc[1]).abs <= 1)
end
    

def updateT(hLoc, tLoc)
  newT = tLoc.clone
  if adjacent(hLoc, tLoc)
    return tLoc
  end
  newT[0] += sign(hLoc[0] - tLoc[0])
  newT[1] += sign(hLoc[1] - tLoc[1])
  return newT
end

def part1(input)
  locations = Set[]
  locations.add([0, 0])
  hLoc = [0, 0]
  tLoc = [0, 0]
  for i in input
    sp = i.split(" ")
    dir = sp[0]
    count = sp[1].to_i
    for j in 0...count
      hLoc = updateH(hLoc, dir)
      tLoc = updateT(hLoc, tLoc)
      locations.add(tLoc)
    end
  end
  return locations.size
end

def part2(input)
  knots = (0..9).to_a
  tailLocations = Set[]
  tailLocations.add([0, 0])
  startLocs = []
  knots.each { |i| 
    startLocs.append([0, 0])
  }
  for i in input
    sp = i.split(" ")
    dir = sp[0]
    count = sp[1].to_i
    for j in 0...count
      startLocs[0] = updateH(startLocs[0], dir)
      for k in 1..9
        startLocs[k] = updateT(startLocs[k - 1], startLocs[k])
      end
      tailLocations.add(startLocs[9])
    end
  end
  return tailLocations.size
end

#puts part1(data)
puts part2(data)