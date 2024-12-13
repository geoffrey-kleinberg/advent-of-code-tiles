require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def getManDist(loc1, loc2)
  return (loc1[0] - loc2[0]).abs + (loc1[1] - loc2[1]).abs
end

def part1(input)
  goalY = 2000000
  #goalY = 10
  sensors = []
  beacons = Set[]
  closest = {}
  dists = {}
  impossible = Set[]
  for i in input
    sensorLoc = i.split(": ")[0].split("at ")[1]
    sensorLoc = sensorLoc.split(", ").map { |j| j.split("=")[1].to_i }
    sensors << sensorLoc
    beaconLoc = i.split("is at ")[1]
    beaconLoc = beaconLoc.split(", ").map { |j| j.split("=")[1].to_i }
    beacons.add(beaconLoc)
    closest[sensorLoc] = beaconLoc
    dists[sensorLoc] = getManDist(sensorLoc, beaconLoc)
  end
  for i in sensors
    d = dists[i]
    for j in (i[0] - d)..(i[0] + d)
      k = goalY
      if getManDist(i, [j, k]) <= d
        impossible.add([j, k])
      end
    end
  end
  return impossible.to_a.count { |i| i[1] == goalY } - beacons.to_a.count { |i| i[1] == goalY }
end

def getIntersect(r1, r2)
  result = []
  if r1[1] < r2[0] - 1
    return [false, r2[0] - 1]
  end
  result[0] = [r1[0], r2[0]].min
  result[1] = [r1[1], r2[1]].max
  return result
end

def part2(input)
  maxXY = 4000000
  #maxXY = 20
  sensors = []
  beacons = Set[]
  closest = {}
  dists = {}
  impossible = Set[]
  for i in input
    sensorLoc = i.split(": ")[0].split("at ")[1]
    sensorLoc = sensorLoc.split(", ").map { |j| j.split("=")[1].to_i }
    sensors << sensorLoc
    beaconLoc = i.split("is at ")[1]
    beaconLoc = beaconLoc.split(", ").map { |j| j.split("=")[1].to_i }
    beacons.add(beaconLoc)
    closest[sensorLoc] = beaconLoc
    dists[sensorLoc] = getManDist(sensorLoc, beaconLoc)
  end
  for r in 0..maxXY
    #puts r if r % 100000 == 0
    rowPossible = false
    notAllowedRanges = []
    for i in sensors
      distFromRow = (i[0] - r).abs
      remaining = dists[i] - distFromRow.abs
      next if remaining < 0
      minX = [0, i[1] - remaining].max
      maxX = [maxXY, i[1] + remaining].min
      notAllowedRanges << [minX, maxX]
    end
    notAllowedRanges = notAllowedRanges.sort { |i, j| i[0] <=> j[0] }
    while notAllowedRanges.length > 1
      union = getIntersect(notAllowedRanges[0], notAllowedRanges[1])
      if union[0]
        notAllowedRanges = notAllowedRanges.drop(2)
        notAllowedRanges.prepend(union)
      else
        return r * 4000000 + union[1]
      end
    end
  end
end

#puts part1(data)
puts part2(data)