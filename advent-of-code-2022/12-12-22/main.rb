fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def getNeighbors(loc, maxX, maxY)
  neighbors = []
  for i in -1..1
    for j in -1..1
      next if i == 0 and j == 0
      next if not (i == 0 or j == 0)
      neighbors << [loc[0] + i, loc[1] + j]
    end
  end
  neighbors.keep_if { |i| i.all? { |j| j >= 0} }
  neighbors.keep_if { |i| i[0] < maxX and i[1] < maxY}
  return neighbors
end

def getHeuristic(loc, endLoc)
  return (loc[0] - endLoc[0]).abs + (loc[1] - endLoc[1]).abs
end

def part1(input)
  letters = 'abcdefghijklmnopqrstuvwxyz'
  startLoc = [-1, -1]
  endLoc = [-1, -1]
  for i in 0...input.length
    if input[i].include? "S"
      startLoc = [i, input[i].index("S")]
      input[i] = input[i].split("S").join("a")
    end
    if input[i].include? "E"
      endLoc = [i, input[i].index("E")]
      input[i] = input[i].split("E").join("z")
    end
  end
  numberGrid = []
  input.each { |i|
    numberGrid << i.split("").map { |j| letters.index(j) }
  }
  adjMap = {}
  for i in 0...numberGrid.length
    for j in 0...numberGrid[i].length
      height = numberGrid[i][j]
      neighbors = getNeighbors([i, j], numberGrid.length, numberGrid[i].length)
      for k in neighbors
        if numberGrid[k[0]][k[1]] - height <= 1
          if not adjMap[[i, j]]
            adjMap[[i, j]] = []
          end
          adjMap[[i, j]].append(k)
        end
      end
    end
  end
  #dijkstra on adjMap
  paths = { startLoc => [startLoc] }
  distances = { 0 => [startLoc]}
  cur = startLoc
  dist = 0
  checked = []
  while true
    next if checked.include? cur
    if cur == endLoc
      print paths[cur].length - 1
      puts
      return dist
    end
    for i in adjMap[cur]
      if not distances[dist + 1]
        distances[dist + 1] = []
      end
      paths[i] = paths[cur].clone + [i]
      distances[dist + 1].append(i) if not checked.include? i
    end
    distances[dist].delete(cur)
    if distances[dist].length == 0
      distances.delete(dist)
    end
    checked.append(cur)
    dist = distances.keys.min
    cur = distances[dist][0]
  end
end

def part2(input)
  letters = 'abcdefghijklmnopqrstuvwxyz'
  startLoc = [-1, -1]
  endLoc = [-1, -1]
  for i in 0...input.length
    if input[i].include? "S"
      startLoc = [i, input[i].index("S")]
      input[i] = input[i].split("S").join("a")
    end
    if input[i].include? "E"
      endLoc = [i, input[i].index("E")]
      input[i] = input[i].split("E").join("z")
    end
  end
  numberGrid = []
  input.each { |i|
    numberGrid << i.split("").map { |j| letters.index(j) }
  }
  adjMap = {}
  for i in 0...numberGrid.length
    for j in 0...numberGrid[i].length
      height = numberGrid[i][j]
      neighbors = getNeighbors([i, j], numberGrid.length, numberGrid[i].length)
      for k in neighbors
        if numberGrid[k[0]][k[1]] - height <= 1
          if not adjMap[[i, j]]
            adjMap[[i, j]] = []
          end
          adjMap[[i, j]].append(k)
        end
      end
    end
  end
  distances = { 0 => [endLoc] }
  closest = distances.keys.min
  curNode = distances[closest][0]
  checked = []
  lowest = 26
  while true
    height = numberGrid[curNode[0]][curNode[1]]
    if numberGrid[curNode[0]][curNode[1]] == 0
      return closest
    end
    next if checked.include? curNode
    checked.append(curNode)
    for i in getNeighbors(curNode, numberGrid.length, numberGrid[0].length)
      if adjMap[i].include? curNode
        next if checked.include? i
        if not distances[closest + 1]
          distances[closest + 1] = []
        end
        distances[closest + 1].append(i) if not distances[closest + 1].include? i
      end
    end
    distances[closest].delete_at(0)
    distances.delete_if { |key, value| value.length == 0 }
    closest = distances.keys.min
    curNode = distances[closest][0]
  end
end

#puts part1(data)
puts part2(data)