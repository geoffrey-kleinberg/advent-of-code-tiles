require 'set'

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

$m12Time = 0
$m12Iterations = 0

def matches12WithOrientationRight(vectors1, vectors2)
  t = Time.now
  a = (vectors1.size + vectors2.size - vectors1.merge(vectors2).size) >= 12
  $m12Time += (Time.now - t)
  $m12Iterations += 1
  return a
end

class Array
  
  @@timeOrienting = 0
  @@orients = 0
  @@saved = {}
  
  def orient(facing, up)
    if (a = @@saved[[self, facing, up]])
      @@timeOrienting += Time.now - t
      return a
    end
    f = self.clone
    newF = []
    if facing == "+x"
      newF[0] = f[0]
      if up == "+z"
        newF[1], newF[2] = f[1], f[2]
      elsif up == "-z"
        newF[2] = f[2] * -1
        newF[1] = f[1] * -1
      elsif up == "+y"
        newF[1], newF[2] = f[2], (f[1] * -1)
      elsif up == "-y"
        newF[1], newF[2] = (f[2] * -1), f[1]
      end
    elsif facing == "-x"
      newF[0] = f[0] * -1
      if up == "+z"
        newF[1] = f[1] * -1
        newF[2] = f[2]
      elsif up == "-z"
        newF[2] = f[2] * -1
        newF[1] = f[1]
      elsif up == "+y"
        newF[1], newF[2] = f[2], f[1]
      elsif up == "-y"
        newF[1], newF[2] = (f[2] * -1), (f[1] * -1)
      end
    elsif facing == "+y"
      if up == "+x"
        newF[0], newF[1], newF[2] = f[2], f[0], f[1]
      elsif up == "-x"
        newF[0], newF[1], newF[2] = (f[2] * -1), f[0], (f[1] * -1)
      elsif up == "+z"
        newF[0], newF[1] = (f[1] * -1), f[0]
        newF[2] = f[2]
      elsif up == "-z"
        newF[0], newF[1] = f[1], f[0]
        newF[2] = f[2] * -1
      end
    elsif facing == "-y"
      if up == "+x"
        newF[0], newF[1], newF[2] = f[2], (f[0] * -1), (f[1] * -1)
      elsif up == "-x"
        newF[0], newF[1], newF[2] = (f[2] * -1), (f[0] * -1), f[1]
      elsif up == "+z"
        newF[0], newF[1] = f[1], (f[0] * -1)
        newF[2] = f[2]
      elsif up == "-z"
        newF[0], newF[1] = (f[1] * -1), (f[0] * -1)
        newF[2] = f[2] * -1
      end
    elsif facing == "+z"
      if up == "+x"
        newF[0], newF[2] = f[2], f[0]
        newF[1] = f[1] * -1
      elsif up == "-x"
        newF[0], newF[2] = (f[2] * -1), (f[0])
        newF[1] = f[1]
      elsif up == "+y"
        newF[0], newF[1], newF[2] = f[1], f[2], f[0]
      elsif up == "-y"
        newF[0], newF[1], newF[2] = (f[1] * -1), (f[2] * -1), f[0]
      end
    elsif facing == "-z"
      if up == "+x"
        newF[0], newF[2] = f[2], (f[0] * -1)
        newF[1] = f[1]
      elsif up == "-x"
        newF[0], newF[2] = (f[2] * -1), (f[0] * -1)
        newF[1] = f[1] * -1
      elsif up == "+y"
        newF[0], newF[1], newF[2] = (f[1] * -1), f[2], (f[0] * -1)
      elsif up == "-y"
        newF[0], newF[1], newF[2] = f[1], (f[2] * -1), (f[0] * -1)
      end
    end
    return newF
  end
  
  def orientAll(facing, up)
    @@orients += 1
    t = Time.now
    if (a = @@saved[[self, facing, up]])
      @@timeOrienting += Time.now - t
      return a
    end
    a = self.map do |f|
      f.orient(facing, up)
    end
    @@timeOrienting += Time.now - t
    @@saved[[self, facing, up]] = a
    return a
  end
  
  def self.getTime
    return @@timeOrienting
  end
  
  def self.numOrients
    return @@orients
  end
  
  def self.avgTime
    return @@timeOrienting / @@orients
  end
  
end

class Set
  
  def orient(facing, up)
    return self.to_a.orientAll(facing, up).to_set
  end
  
end

def matches12(vectors1, vectors2)
  facingPossibilities = ["+x", "+y", "+z", "-x", "-y", "-z"]
  upPossibilities = facingPossibilities.clone
  for facing in facingPossibilities
    for up in upPossibilities
      next if facing.slice(1) == up.slice(1)
      fVectors = vectors2.orient(facing, up)
      matches = nil
      if matches12WithOrientationRight(vectors1, fVectors)
        yield facing, up
        return true
      end
    end
  end
  return false
end

def isAdjacent(s1Beacons, s2Beacons, s1Vectors, s2Vectors, orientation)
  for i in s2Beacons.slice(0, s2Beacons.length - 11)
    for j in s1Beacons.slice(0, s1Beacons.length - 11)
      twoFacing = nil
      twoUp = nil
      flipped = nil
      if matches12(s1Vectors[j].orient(orientation[0], orientation[1]), s2Vectors[i]) { |b, c| 
        twoFacing = b
        twoUp = c
      }
        yield j, i, twoFacing, twoUp
        return true
      end
    end
  end
  return false
end

def part1(input)
  tt = Time.now
  t = Time.now
  scannerBeacons = {}
  scannerLocations = {
    0 => [0, 0, 0]
  }
  located = 1
  scannerVectors = {}
  scannerOrientations = {
    0 => ["+x", "+z"]
  }
  scannerNum = -1
  for i in input
    if i.include? "---"
      scannerNum += 1
      scannerBeacons[scannerNum] = []
    elsif i == ""
      next
    else
      scannerBeacons[scannerNum] << i.split(",").map { |j| j.to_i }
    end
  end
  for i in scannerBeacons.keys
    scannerVectors[i] = {}
    for j in scannerBeacons[i]
      scannerVectors[i][j] = Set[]
      for k in scannerBeacons[i]
        scannerVectors[i][j].add(k.map.with_index { |val, ind| val - j[ind] })
      end
    end
  end
  scanned = []
  puts "about to locate"
  puts "preprocess time: " + (Time.now - t).to_s
  t = Time.now
  processTime = 0
  adjacentTime = 0
  while located < (scannerNum + 1)
    for i in 0..scannerNum
      next if scanned.include? i
      next if not scannerLocations.keys.include? i
      homeScanner = i
      for possibleAdjacent in scannerBeacons.keys
        next if homeScanner == possibleAdjacent
        next if scannerLocations.include? possibleAdjacent
        puts "checking " + homeScanner.to_s + " and " + possibleAdjacent.to_s
        p1 = nil
        p2 = nil
        twoFacing = nil
        twoUp = nil
        adjacentT = Time.now
        if isAdjacent(scannerBeacons[homeScanner], scannerBeacons[possibleAdjacent], scannerVectors[homeScanner], scannerVectors[possibleAdjacent], scannerOrientations[homeScanner]) { |a, b, c, d|
          p1 = a
          p2 = b
          twoFacing = c
          twoUp = d
        }
          t1 = Time.now
          located += 1
          puts "located: " + located.to_s
          scannerOrientations[possibleAdjacent] = [twoFacing, twoUp]
          oneFacing = scannerOrientations[homeScanner][0]
          oneUp = scannerOrientations[homeScanner][1]
          
          p1 = p1.orient(oneFacing, oneUp)
          p2 = p2.orient(twoFacing, twoUp)
          scannerLocations[possibleAdjacent] = p1.map.with_index do |val, ind|
            val - p2[ind] + scannerLocations[homeScanner][ind]
          end
          puts scannerLocations
          processTime += Time.now - t1
        end
        adjacentTime += Time.now - adjacentT
      end
      scanned << i
      print scanned
      puts
    end
  end
  adjacentTime -= processTime + Array.getTime
  puts scannerOrientations
  puts "scanners found"
  puts "loop time: " + (Time.now - t - processTime).to_s
  t = Time.now
  beacons = Set[]
  for i in scannerLocations.keys
    scannerFacing = scannerOrientations[i][0]
    scannerUp = scannerOrientations[i][1]
    for j in scannerBeacons[i]
      j = j.orient(scannerFacing, scannerUp)
      beaconLoc = j.map.with_index { |val, ind|
        val + scannerLocations[i][ind]
      }
      beacons.add(beaconLoc)
    end
  end
  puts "process time: " + processTime.to_s
  puts "beacon time: " + (Time.now - t).to_s
  puts "time to check adjacency (minus orientations): #{adjacentTime}"
  puts "matches 12 ran #{$m12Iterations} times in a total of #{$m12Time}, average #{$m12Time / $m12Iterations}"
  puts "#{Array.numOrients} orients in #{Array.getTime} with average time #{Array.avgTime}"
  puts "total time: " + (Time.now - tt).to_s
  yield scannerLocations
  return beacons.size
end

def parseScanners(string)
  pairs = string.split("], ")
  scanners = {}
  for i in pairs
    key, value = i.split("=>")
    key = key.to_i
    value = value.slice(1, value.length - 1).split(", ").map { |k| k.to_i }
    scanners[key] = value
  end
  return scanners
end

def part2(input)
  scanners = nil
  puts part1(input) { |i| scanners = i }
  t = Time.now
  maxD = 0
  for i in 0...scanners.length
    for j in (i + 1)...scanners.length
      iLoc = scanners[i]
      jLoc = scanners[j]
      manhattanDist = 0
      iLoc.each.with_index { |val, ind|
        manhattanDist += (val - jLoc[ind]).abs
      }
      maxD = [manhattanDist, maxD].max
    end
  end
  puts "Part 2 time: #{Time.now - t}"
  return maxD
end

#puts part1(sinput.clone)
#puts part1(input.clone)

#puts

puts part2(sinput.clone)
