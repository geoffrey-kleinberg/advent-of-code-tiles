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
  heightMap = input.map { |i| i.split("") }
  sum = 0
  lowPoints = []
  for i in 0...heightMap.length
    for j in 0...heightMap[i].length
      neighbors = []
      if i == 0
        if j == 0
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i + 1][j]
        elsif j == heightMap[i].length - 1
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i + 1][j]
        else
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i + 1][j]
        end
      elsif i == heightMap.length - 1
        if j == 0
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i - 1][j]
        elsif j == heightMap[i].length - 1
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i - 1][j]
        else
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i - 1][j]
        end
      else
        if j == 0
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i - 1][j]
          neighbors << heightMap[i + 1][j]
        elsif j == heightMap[i].length - 1
          #puts heightMap[i][j]
          neighbors << heightMap[i - 1][j]
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i + 1][j]
          #print neighbors
          #puts
        else
          neighbors << heightMap[i][j + 1]
          neighbors << heightMap[i][j - 1]
          neighbors << heightMap[i + 1][j]
          neighbors << heightMap[i - 1][j]
        end
      end
      if neighbors.all? { |k| k.to_i > heightMap[i][j].to_i }
        sum += 1 + heightMap[i][j].to_i
        lowPoints << [i, j]
        #puts heightMap[i][j], i, j
        #puts
      end
    end
  end
  yield lowPoints
  return sum
end

require 'set'

def iterateBasin(hMap, basin)
  toAdd = Set[]
  #print basin
  #puts
  for i in basin
    x, y = i
    #check right until 9
    rightDisp = 1
    while y + rightDisp < hMap[x].length and hMap[x][y + rightDisp] != 9 and not basin.include? [x, y + rightDisp]
      toAdd.add([x, y + rightDisp])
      rightDisp += 1
    end
    #puts "right good"
    #check left until 9
    leftDisp = 1
    while y - leftDisp >= 0 and hMap[x][y - leftDisp] != 9 and not basin.include? [x, y - leftDisp]
      toAdd.add([x, y - leftDisp])
      leftDisp += 1
    end
    #puts "left good"
    #check above until 9
    upDisp = 1
    while x - upDisp >= 0 and hMap[x - upDisp][y] != 9 and not basin.include? [x - upDisp, y]
      toAdd.add([x - upDisp, y])
      upDisp += 1
    end
    #puts "up good"
    #check down until 9
    downDisp = 1
    while x + downDisp < hMap.length and hMap[x + downDisp][y] != 9 and not basin.include? [x + downDisp, y]
      toAdd.add([x + downDisp, y])
      downDisp += 1
    end
    #puts "down good"
  end
  
  return toAdd
end

def collectBasin(hMap, point)
  x = point[0]
  y = point[1]
  basin = Set[point]
  count = 0
  loop do
    newPoints = iterateBasin(hMap, basin)
    #print newPoints
    #puts
    break if newPoints.size == 0
    newPoints.each { |i| basin.add(i) }
  end
  #print basin
  #puts
  return basin.size
end

def part2(input)
  heightMap = input.map { |i| i.split("").map { |j| j.to_i }}
  lowPoints = []
  part1(input) { |i|
    lowPoints = i
  }
  sizes = []
  for i in lowPoints
    #print i
    #puts
    basinSize = collectBasin(heightMap, i)
    sizes << basinSize
    #puts basin
  end
  return sizes.sort.slice(-3, 3).inject(1) { |prod, i| prod * i }
end

puts part1(sinput.clone) { |i| i }
puts part1(input.clone) { |i| i }

puts

puts part2(sinput.clone)
puts part2(input.clone)