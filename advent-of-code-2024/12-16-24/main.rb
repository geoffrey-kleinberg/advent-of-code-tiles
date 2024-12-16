require 'set'

day = "16"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getManDist(start, goal)
  return (start[0] - goal[0]).abs + (start[1] - goal[1]).abs
end

def part1(input)
    grid = input.map { |i| i.split("") }
    start = nil
    goal = nil
    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "S"
          start = [i, j]
          grid[i][j] = "."
        end
        if grid[i][j] == "E"
          goal = [i, j]
          grid[i][j] = "."
        end
      end
    end

    visited = Set[]

    dirs = {
        "E" => [0, 1],
        "N" => [-1, 0],
        "S" => [1, 0],
        "W" => [0, -1]
    }

    queue = {
        getManDist(start, goal) => [[start, "E", 0]]
    }

    while true
      shortest = queue.keys.min
      cur = queue[shortest].shift
      if queue[shortest].length == 0
        queue.delete(shortest)
      end
      loc = cur[0]
      visited.add(loc)
      dir = cur[1]
      score = cur[2]
      if loc == goal
        return score
      end

      for d in ["E", "S", "N", "W"]
        nextLoc = [loc[0] + dirs[d][0], loc[1] + dirs[d][1]]
        next if grid[nextLoc[0]][nextLoc[1]] == "#"
        next if visited.include? nextLoc

        nextScore = score + 1
        if d != dir
          nextScore += 1000
        end

        heuristic = nextScore + getManDist(nextLoc, goal)

        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append([nextLoc, d, nextScore])
      end
    end

end


# returns a list of 
# [ list of sets of best paths starting at start and ending at goal,
# the score of that path]
def getBestPaths(grid, start, dir, goal, bestScore, curScore, path, dirs, memo)
#   if curScore > bestScore
#     return [[], false]
#   end
  if start == goal
    return [[Set[goal]], 0]
  end
  if memo[[start, dir]]
    # remScore = memo[[start, dir]][1]
    # if curScore + remScore > bestScore
    #   return [[], 0]
    # end
    return memo[[start, dir]]
  end

  bestPaths = []

  for d in ["E", "S", "N", "W"]
    nextLoc = [start[0] + dirs[d][0], start[1] + dirs[d][1]]

    next if grid[nextLoc[0]][nextLoc[1]] == "#"

    next if path.include? nextLoc

    score = 1
    if d != dir
      score += 1000
    end

    newPath = path + Set[nextLoc]

    gbp = getBestPaths(grid, nextLoc, d, goal, bestScore, score, newPath, dirs, memo)

    # print nextLoc
    # puts
    # puts d
    # puts score

    # print gbp
    # puts 

    for p in gbp[0]
      pNew = p + Set[start]
      bestPaths.append([pNew, gbp[1] + score])
    end

  end
  
  if bestPaths == []
    # puts "weird"
    memo[[start, dir]] = [[], Float::INFINITY]
    return [[], Float::INFINITY]
  end

  fastest = bestPaths.min { |i, j| i[1] <=> j[1] }
  fastest = fastest[1]

  bestPaths = bestPaths.filter { |i| i[1] == fastest }.map { |i| i[0] }


#   if bestPaths.length > 0
  memo[[start, dir]] = [bestPaths, fastest]
  return [bestPaths, fastest]
#   else
#     return [bestPaths, false]
#   end

end

# what if we:
# look at every combination of square and direction, sorted by reverse manhattan distance from goal
# then, calculate the shortest path from start to goal and its score
# remember that score
# move out by MD 1, do the same

def part2(input)
    grid = input.map { |i| i.split("") }
    start = nil
    goal = nil
    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "S"
          start = [i, j]
          grid[i][j] = "."
        end
        if grid[i][j] == "E"
          goal = [i, j]
          grid[i][j] = "."
        end
      end
    end

    bestScore = part1(input)
    bestMoves = bestScore % 1000

    # puts bestMoves

    visited = {}

    dirs = {
        "E" => [0, 1],
        "N" => [-1, 0],
        "S" => [1, 0],
        "W" => [0, -1]
    }

    bestPaths = []
    queue = {
        getManDist(start, goal) => [[Set[start], "E", 0, start, false]]
    }

    while queue.keys.length > 0
      shortest = queue.keys.min
      cur = queue[shortest].shift
      if queue[shortest].length == 0
        queue.delete(shortest)
      end
      curPath = cur[0]
      loc = cur[3]
      dir = cur[1]
      score = cur[2]
      onTurn = cur[4]
      visited[loc] = score
      if not onTurn
        visited[loc] += 1000
      end
      if loc == goal
        bestPaths.append(curPath)
      end

      for d in ["E", "S", "N", "W"]
        nextLoc = [loc[0] + dirs[d][0], loc[1] + dirs[d][1]]
        next if grid[nextLoc[0]][nextLoc[1]] == "#"
        next if curPath.include? nextLoc

        nextScore = score + 1
        if d != dir
          nextScore += 1000
        end

        next if visited[nextLoc] and visited[nextLoc] < nextScore

        heuristic = nextScore + getManDist(nextLoc, goal)

        next if heuristic > bestScore

        nextPath = curPath + Set[nextLoc]

        next if nextPath.size > bestMoves + 1

        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append([nextPath, d, nextScore, nextLoc, (d != dir)])
      end
    end

    onPaths = Set[]
    for i in 0...bestPaths.length
      onPaths += bestPaths[i]
    end

    return onPaths.size
end

puts part1(data)
puts part2(data)