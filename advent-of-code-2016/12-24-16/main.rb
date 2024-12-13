require 'set'

day = "24"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getManhattan(loc1, loc2)
  return (loc1[0] - loc2[0]).abs + (loc1[1] - loc2[1]).abs
end

def getDist(loc1, loc2, grid)
  queue = {
    getManhattan(loc1, loc2) => [[loc1]]
  }

  seen = Set[]

  while queue.length > 0
    minHeuristic = queue.keys.min
    cur = queue[minHeuristic].shift
    if queue[minHeuristic].length == 0
      queue.delete(minHeuristic)
    end
    last = cur.last
    seen.add(last)
    if last == loc2
      return cur.length - 1
    end

    for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
      nextLoc = [last[0] + dir[0], last[1] + dir[1]]
      next if grid[nextLoc[0]][nextLoc[1]] == "#"
      next if seen.include? nextLoc
      newList = cur + [nextLoc]
      newHeuristic = getManhattan(nextLoc, loc2) + cur.length
      if not queue[newHeuristic]
        queue[newHeuristic] = []
      end
      queue[newHeuristic].append(newList)
    end
  end
end

def part1(input)
  grid = input.map { |i| i.split("") }
  nums = {

  }
  for i in 0...grid.length
    for j in 0...grid[i].length
      if grid[i][j] != "." and grid[i][j] != "#"
        nums[grid[i][j].to_i] = [i, j]
        grid[i][j] = "."
      end
    end
  end

  print nums
  puts

  graph = {}
  for i in 0...nums.keys.length
    graph[i] = []
    for j in 0...nums.keys.length
      if graph[j]
        if graph[j][i]
          graph[i][j] = graph[j][i]
          next
        end
      end
      graph[i][j] = getDist(nums[i], nums[j], grid)
    end
  end

  print graph
  puts

  toVisit = (1..nums.keys.max).to_a

  best = Float::INFINITY

  toVisit.permutation do |order|
    at = 0
    dist = 0
    for i in order
      dist += graph[at][i]
      at = i
    end
    if dist < best
      best = dist
    end
  end

  return best
end

def part2(input)
  grid = input.map { |i| i.split("") }
  nums = {

  }
  for i in 0...grid.length
    for j in 0...grid[i].length
      if grid[i][j] != "." and grid[i][j] != "#"
        nums[grid[i][j].to_i] = [i, j]
        grid[i][j] = "."
      end
    end
  end

  print nums
  puts

  graph = {}
  for i in 0...nums.keys.length
    graph[i] = []
    for j in 0...nums.keys.length
      if graph[j]
        if graph[j][i]
          graph[i][j] = graph[j][i]
          next
        end
      end
      graph[i][j] = getDist(nums[i], nums[j], grid)
    end
  end

  print graph
  puts

  toVisit = (1..nums.keys.max).to_a

  best = Float::INFINITY

  toVisit.permutation do |order|
    at = 0
    dist = 0
    for i in order
      dist += graph[at][i]
      at = i
    end
    dist += graph[at][0]
    if dist < best
      best = dist
    end
  end

  return best
end

# puts part1(data)
puts part2(data)