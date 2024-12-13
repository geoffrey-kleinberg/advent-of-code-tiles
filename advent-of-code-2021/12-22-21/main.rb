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
  cubes = []
  for i in -50..50
    cubes << []
    for j in -50..50
      cubes[i + 50] << []
    end
  end
  for line in input
    two = line.split(" ")
    range = two[1].split(",")
    xMin, xMax = range[0].split("=")[1].split("..").map { |i| i.to_i }
    yMin, yMax = range[1].split("=")[1].split("..").map { |i| i.to_i }
    zMin, zMax = range[2].split("=")[1].split("..").map { |i| i.to_i }
    next if xMax < -50 or xMin > 50 or yMax < -50 or yMin > 50 or zMin < -50 or zMax > 50
    #puts xMin, xMax, yMin, yMax, zMin, zMax
    #puts
    if two[0] == "on"
      for x in xMin..xMax
        for y in yMin..yMax
          for z in zMin..zMax
            cubes[x + 50][y + 50][z + 50] = true
          end
        end
      end
    else
      for x in xMin..xMax
        for y in yMin..yMax
          for z in zMin..zMax
            cubes[x + 50][y + 50][z + 50] = false
          end
        end
      end
    end
    #puts line
    #puts cubes.flatten.count(true)
  end
  return cubes.flatten.count(true)
end

def isValid(region)
  return (region[3] > 0 and region[4] > 0 and region[5] > 0)
end

def intersect(region1, region2)
  xMin = [region1[0], region2[0]].max
  yMin = [region1[1], region2[1]].max
  zMin = [region1[2], region2[2]].max
  xMax = [region1, region2].map { |i| i[0] + i[3] - 1}.min
  yMax = [region1, region2].map { |i| i[1] + i[4] - 1}.min
  zMax = [region1, region2].map { |i| i[2] + i[5] - 1}.min
  xLen = xMax - xMin + 1
  yLen = yMax - yMin + 1
  zLen = zMax - zMin + 1
  int = [xMin, yMin, zMin, xLen, yLen, zLen]
  if not isValid(int)
    #doesn't intersect
    return [int, false]
  else
    
    #newRegions = removeInt(region1, int)
    #does intersect
    return [int, true]
  end
  #returns [intersected region, array of new regions in region1]
end

def getVolume(region)
  return region.slice(3, 3).inject(1) { |prod, val| prod * val }
end

def part2(input)
  counted = {}
  first = true
  on = 0
  num = 0
  for line in input
    t = Time.now
    two = line.split(" ")
    range = two[1].split(",")
    xMin, xMax = range[0].split("=")[1].split("..").map { |i| i.to_i }
    yMin, yMax = range[1].split("=")[1].split("..").map { |i| i.to_i }
    zMin, zMax = range[2].split("=")[1].split("..").map { |i| i.to_i }
    xLen = xMax - xMin + 1
    yLen = yMax - yMin + 1
    zLen = zMax - zMin + 1
    region = [xMin, yMin, zMin, xLen, yLen, zLen]
    if first
      counted[1] = [region]
      first = false
    else
      if two[0] == "on"
        for i in counted.keys.sort.reverse
          if not counted[i + 1]
            counted[i + 1] = []
          end
          for j in counted[i]
            int = intersect(region, j)
            counted[i + 1] << int[0] if int[1]
          end
        end
        counted[1] << region
      #puts counted
      else
        for i in counted.keys.sort
          if not counted[i - 1]
            counted[i - 1] = []
          end
          for j in counted[i]
            int = intersect(region, j)
            counted[i - 1] << int[0] if int[1]
          end
        end
      end
    end
    num += 1
    puts "iteration #{num}: #{Time.now - t}"
  end
  puts "counted"
  for i in counted.keys.sort
    for j in counted[i]
      if i % 2 == 1
        on += getVolume(j)
      else
        on -= getVolume(j)
      end
    end
  end
  return on
end

#puts part1(sinput.clone)
#puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)