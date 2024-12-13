require 'set'

day = "10"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getGrid(grid, i, j)
  if i < 0 or j < 0 or i >= grid.length or j >= grid[i].length
    return nil
  end
  return grid[i][j]
end

def part1(input)
    grid = input.map { |i| i.split("").map { |j| (j == "." ? -1 : j.to_i) } }
    queue = []
    trailheads = {}
    for i in 0...grid.length
      for j in 0...grid[i].length
        if getGrid(grid, i, j) == 0
          trailheads[[i, j]] = Set.new()
          queue.append([[i, j]])
        end
      end
    end

    while queue.length > 0
      curTrail = queue.shift
      cur = curTrail[-1]
      height = getGrid(grid, cur[0], cur[1])
      for dir in [[-1, 0], [0, -1], [1, 0], [0, 1]]
        nextI = cur[0] + dir[0]
        nextJ = cur[1] + dir[1]
        nextHeight = getGrid(grid, nextI, nextJ)
        next if not nextHeight
        if nextHeight - height == 1
          if nextHeight == 9
            trailheads[curTrail[0]].add([nextI, nextJ])
          else
            newTrail = curTrail + [[nextI, nextJ]]
            queue.append(newTrail)
          end
        end
      end
    end

    # print trailheads
    # puts 

    return trailheads.values.map { |i| i.size }.sum
end

def getDistinctPaths(grid, i, j)
  height = getGrid(grid, i, j)
  if height == 9
    return 1
  end
  total = 0
  for dir in [[-1, 0], [0, -1], [1, 0], [0, 1]]
    nextI = i + dir[0]
    nextJ = j + dir[1]
    nextHeight = getGrid(grid, nextI, nextJ)
    next if not nextHeight
    if nextHeight - height == 1
      total += getDistinctPaths(grid, nextI, nextJ)
    end
  end
  return total
end

def part2(input)
    grid = input.map { |i| i.split("").map { |j| (j == "." ? -1 : j.to_i) } }
    trailheads = []
    for i in 0...grid.length
      for j in 0...grid[i].length
        if getGrid(grid, i, j) == 0
          trailheads.append([i, j])
        end
      end
    end

    total = 0

    for i in trailheads
      rating = getDistinctPaths(grid, i[0], i[1])
    #   puts rating
      total += rating
    end

    return total
end

puts part1(data)
puts part2(data)