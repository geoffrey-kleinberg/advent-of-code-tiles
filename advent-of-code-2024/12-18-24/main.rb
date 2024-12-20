require 'set'

day = "18"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getGrid(loc, fallen)
  if loc[0] < 0 or loc[1] < 0 or loc[0] > 70 or loc[1] > 70
    return false
  end
  if fallen.include? loc
    return false
  end
  return true
end

def manhattan(p1, p2)
  return (p1[0] - p2[0]).abs + (p1[1] - p2[1]).abs
end

# 339 is wrong
def part1(input)
    fallen = input[0...1024].map { |i| i.split(",").map { |j| j.to_i } }.to_set

    location = [0, 0]
    seen = Set[location]
    target = [70, 70]
    queue = {
        manhattan(location, target) => [[location]]
    }
    while queue.size > 0
      shortest = queue.keys.min
      cur = queue[shortest].shift
      if queue[shortest].length == 0
        queue.delete(shortest)
      end
      lastNode = cur.last

      if lastNode == target
        return cur.length - 1
      end

      for d in [[0, 1], [1, 0], [-1, 0], [0, -1]]
        nextLoc = [lastNode[0] + d[0], lastNode[1] + d[1]]
        next if seen.include? nextLoc
        seen.add(nextLoc)
        next if not getGrid(nextLoc, fallen)

        heuristic = manhattan(nextLoc, target) + cur.length + 1

        newPath = cur + [nextLoc]
        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append(newPath)
      end
    end
end

def region(start, fallen)
  region = Set[]
  queue = [start]
  while queue.length > 0
    lastNode = queue.shift
    next if region.include? lastNode
    region.add(lastNode)
    for d in [[0, 1], [1, 0], [-1, 0], [0, -1]]
        nextLoc = [lastNode[0] + d[0], lastNode[1] + d[1]]
        next if region.include? nextLoc
        next if not getGrid(nextLoc, fallen)

        queue.append(nextLoc)
          
    end
  end
  return region
end


# is there a faster way to do this?
def part2(input)
    input = input.map { |i| i.split(",").map { |j| j.to_i } }
    fallen = Set[]
    for i in input
      fallen.add(i)
      curLoc = [0, 0]
      if not region(curLoc, fallen).include? [70, 70]
        return i.join(",")
      end
    end
end

# puts part1(data)
puts part2(data)