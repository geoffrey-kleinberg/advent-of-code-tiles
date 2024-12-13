require 'set'

day = "13"
file_name = "12-#{day}-16/sampleIn.txt"
# file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getFill(x, y, num)
  val = x*x + 3*x + 2*x*y + y + y*y + num
  return val.to_s(2).count('1') % 2
end

def getHeuristic(current, goal)
  return (current[0] - goal[0]).abs + (current[1] - goal[1]).abs
end

def part1(input)
  walls = {}
  magicNum = 10
  magicNum = 1362
  goal = [7, 4]
  goal = [5, 8]
  

  queue = {
    getHeuristic([1, 1], goal) => [[[1, 1], 0]]
  }

  fastest = {

  }

  maxIter = 140
  iter = 0

  while true
    # if iter >= maxIter
    #   return nil
    # end
    minDist = queue.keys.min
    cur = queue[minDist].shift
    curLoc = cur[0]
    curDist = cur[1]
    fastest[curLoc] = curDist
    
    if curLoc == goal
      return curDist
    end

    for dir in [[1, 0], [0, 1], [-1, 0], [0, -1]]
      toTry = [curLoc[0] + dir[0], curLoc[1] + dir[1]]
      wall = walls[toTry]
      if not wall
        wall = getFill(toTry[0], toTry[1], magicNum)
        walls[toTry] = wall
      end
      next if wall == 1
      next if fastest[toTry] and fastest[toTry] <= curDist + 1
      queueVal = curDist + 1 + getHeuristic(toTry, goal)
      if not queue[queueVal]
        queue[queueVal] = []
      end
      queue[queueVal].append([toTry, curDist + 1])
    end

    if queue[minDist].length == 0
      queue.delete(minDist)
    end

    # print walls
    # puts

    # print queue
    # puts
    # puts

    # iter += 1
  end
end

def part2(input)
  dists = {}

  walls = {}
  magicNum = 1362

  for x in 0..51
    for y in 0..51
      next if (x - 1).abs + (y - 1).abs > 50

      if not walls[[x, y]]
        walls[[x, y]] = getFill(x, y, magicNum)
      end
      if walls[[x, y]] == 1
        next
      end


      goal = [x, y]

      if dists[goal] and dists[goal] <= 50
        next
      end

      queue = {
        getHeuristic([1, 1], goal) => [[[1, 1], 0]]
      }

      while true
        minDist = queue.keys.min
        cur = queue[minDist].shift
        curLoc = cur[0]
        curDist = cur[1]
        dists[curLoc] = curDist
        
        if curLoc == goal
          if curDist <= 50
            break
          end
        end
    
        for dir in [[1, 0], [0, 1], [-1, 0], [0, -1]]
          toTry = [curLoc[0] + dir[0], curLoc[1] + dir[1]]
          wall = walls[toTry]
          if not wall
            wall = getFill(toTry[0], toTry[1], magicNum)
            walls[toTry] = wall
          end
          next if wall == 1
          next if dists[toTry] and dists[toTry] < curDist + 1
          next if curDist >= 50
          queueVal = curDist + 1 + getHeuristic(toTry, goal)
          if not queue[queueVal]
            queue[queueVal] = []
          end
          queue[queueVal].append([toTry, curDist + 1])
        end
    
        if queue[minDist].length == 0
          queue.delete(minDist)
        end

        if queue.keys.length == 0
          break
        end
      end
    end
  end

  return dists.filter { |k, v| k.all? { |i| i >= 0} and v <= 50 }.count
end

puts part1(data)
puts part2(data)