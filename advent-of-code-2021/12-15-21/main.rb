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

def getNeighbors(coord, maxX, maxY)
  neighbors = []
  for i in -1..1
    neighbors << [coord[0] + i, coord[1]]
  end
  for i in -1..1
    neighbors << [coord[0], coord[1] + i]
  end
  neighbors.delete_if { |i| i.any? { |j| j < 0 }}
  neighbors.delete_if { |i| i[0] >= maxY }
  neighbors.delete_if { |i| i[1] >= maxX }
  neighbors.delete(coord)
  return neighbors
end

def getNextNode(nDistances, pathFoundHash)
  minDist = Float::INFINITY
  minPoint = -1
  for i in nDistances.keys
    if not pathFoundHash[i] and nDistances[i] < minDist
      minDist = nDistances[i]
      minPoint = i
    end
  end
  return minPoint
end

def insertionSort(point, dist, sortedArr)
  i = sortedArr.length / 2
  if sortedArr.length == 1
    if dist > sortedArr[0][1]
      sortedArr.insert(1, [point, dist])
    else
      sortedArr.insert(0, [point, dist])
    end
    return sortedArr
  end
  firstHalf = sortedArr.slice(0, i)
  secondHalf = sortedArr.slice(i, sortedArr.length - i)
  if sortedArr[i][1] < dist
    return firstHalf + insertionSort(point, dist, secondHalf)
  else
    return insertionSort(point, dist, firstHalf) + secondHalf
  end
  #while i < sortedArr.length and sortedArr[i][1] < dist
  #  i += 1
  #end
  #sortedArr.insert(i, [point, dist])
  #return sortedArr
end

def insertionSortOld(point, dist, sortedArr)
  i = 0
  while i < sortedArr.length and sortedArr[i][1] < dist
    i += 1
  end
  sortedArr.insert(i, [point, dist])
  return sortedArr
end

def part1(input)
  t1 = Time.now
  graph = {}
  distances = {}
  nonFinalDistances = {}
  pathFoundHash = {}
  sortedPoints = [[[0, 0], 0]]
  distances[[0, 0]] = 0
  yMax = input.length
  xMax = input[0].length
  pt = Time.now
  for i in 0...yMax
    for j in 0...xMax
      point = [i, j]
      nonFinalDistances[point] = Float::INFINITY
      for k in getNeighbors(point, xMax, yMax)
        if graph[point] 
          graph[point] << [k, input[k[0]].slice(k[1]).to_i]
        else
          graph[point] = []
          graph[point] << [k, input[k[0]].slice(k[1]).to_i]
        end
      end
    end
  end
  print "process time: "
  puts Time.now - pt
  lt = Time.now
  start = [0, 0]
  distances[start] = 0
  nonFinalDistances[start] = 0
  totalSortTime = 0
  loop do
    nextNode = sortedPoints[0][0]
    for i in graph[nextNode]
      i1Dist = 0
      if not pathFoundHash[i[0]] and nonFinalDistances[i[0]] > nonFinalDistances[nextNode] + i[1]
        nonFinalDistances[i[0]] = nonFinalDistances[nextNode] + i[1]
        t = Time.now
        sortedPoints = insertionSort(i[0], nonFinalDistances[i[0]], sortedPoints)
        totalSortTime += Time.now - t
      end
    end
    distances[nextNode] = nonFinalDistances[nextNode]
    nonFinalDistances.delete(nextNode)
    sortedPoints.delete_at(0)
    pathFoundHash[nextNode] = true
    break if pathFoundHash[[yMax - 1, xMax - 1]]
  end
  puts "total sort time: " + totalSortTime.to_s
  puts "loop time: " + (Time.now - lt).to_s
  print "total time: "
  puts Time.now - t1
  return distances[[yMax - 1, xMax - 1]]
end

def part2(input)
  newInput = []
  dt = Time.now
  for i in 0...5
    for j in 0...5
      for k in 0...input.length
        for l in 0...input[k].length
          if not newInput[k + input.length * i]
            newInput[k + input.length * i] = []
          end
          val = input[k].slice(l).to_i + i + j
          val = val % 9 if val >= 10
          newInput[k + input.length * i][l + input.length * j] = val
        end
      end
    end
  end
  input = newInput
  puts "input multiplication: " + (Time.now - dt).to_s
  return part1(input.clone)
end


puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)