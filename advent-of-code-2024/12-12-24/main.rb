require 'set'

day = "12"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getCost(region)
  area = region.length
  p = 0
  for t in region
    for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
      neighbor = [t[0] + dir[0], t[1] + dir[1]]
      if not region.include? neighbor
        p += 1
      end
    end
  end
  return p * area
end

def getGrid(grid, i, j)
  if i < 0 or j < 0 or i >= grid.length or j >= grid[i].length
    return nil
  end
  return grid[i][j]
end

def part1(input)
    grid = input.map { |i| i.split("") }

    regions = []
    visited = Set[]

    for i in 0...grid.length
      for j in 0...grid.length
        next if visited.include? [i, j]
        start = [i, j]
        region = []
        queue = [start]
        while queue.length > 0
          cur = queue.shift
          next if not visited.add? cur
          region.append(cur)
          for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
            nextLoc = [cur[0] + dir[0], cur[1] + dir[1]]

            next if visited.include? nextLoc
            next if not getGrid(grid, nextLoc[0], nextLoc[1])

            if getGrid(grid, cur[0], cur[1]) == getGrid(grid, nextLoc[0], nextLoc[1])
              queue.append(nextLoc)
            end
          end
        end
        regions.append(region)
      end
    end

    cost = 0

    for r in regions
      cost += getCost(r)
    end

    return cost
end

def getCorners(adj)
  corners = 0
  if not (adj[0][1] or adj[1][0])
    corners += 1
  end
  if not (adj[0][1] or adj[1][2])
    corners += 1
  end
  if not (adj[1][2] or adj[2][1])
    corners += 1
  end
  if not (adj[1][0] or adj[2][1])
    corners += 1
  end

  if adj[0][1] and adj[1][0] and not adj[0][0]
    corners += 1
  end
  if adj[0][1] and adj[1][2] and not adj[0][2]
    corners += 1
  end
  if adj[1][2] and adj[2][1] and not adj[2][2]
    corners += 1
  end
  if adj[1][0] and adj[2][1] and not adj[2][0]
    corners += 1
  end

  return corners
end

def getCost2(region)
  area = region.length
  corners = 0
  for t in region
    adj = []
    for i in -1..1
      adj.append([])
      for j in -1..1
        next if i == 0 and j == 0
        if region.include? [t[0] + i, t[1] + j]
          adj[i + 1][j + 1] = true
        else
          adj[i + 1][j + 1] = false
        end
      end
    end
    
    corners += getCorners(adj)

    # if getCorners(adj) != 0
    #   print t
    #   puts
    #   puts getCorners(adj)
    # end
    
  end

#   print region
#   puts

#   puts corners

  return area * corners

end

def part2(input)
    grid = input.map { |i| i.split("") }

    regions = []
    visited = Set[]

    for i in 0...grid.length
      for j in 0...grid.length
        next if visited.include? [i, j]
        start = [i, j]
        region = []
        queue = [start]
        while queue.length > 0
          cur = queue.shift
          next if not visited.add? cur
          region.append(cur)
          for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
            nextLoc = [cur[0] + dir[0], cur[1] + dir[1]]

            next if visited.include? nextLoc
            next if not getGrid(grid, nextLoc[0], nextLoc[1])

            if getGrid(grid, cur[0], cur[1]) == getGrid(grid, nextLoc[0], nextLoc[1])
              queue.append(nextLoc)
            end
          end
        end
        regions.append(region)
      end
    end

    cost = 0

    for r in regions
      cost += getCost2(r)
    end

    return cost
end

# puts part1(data)
puts part2(data)