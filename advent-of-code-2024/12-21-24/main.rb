require 'set'

day = "21"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def getAllShortest(start, goal, memo, locations)

  if memo[[start, goal, locations]]
    return memo[[start, goal, locations]]
  end

  shortest = []

  startY = start[0]
  startX = start[1]
  goalY = goal[0]
  goalX = goal[1]

  if startY == goalY
    if startX > goalX
      shortest.append("<" * (startX - goalX))
    elsif goalX > startX
      shortest.append(">" * (goalX - startX))
    else
      shortest.append("")
    end
  elsif startY > goalY
    if startX > goalX
      op1 = "^" * (startY - goalY) + "<" * (startX - goalX)
      op2 = "<" * (startX - goalX) + "^" * (startY - goalY)
      if not (goalX == 0 and startY == 3 and locations == 11)
        shortest.append(op2)
      end
      shortest.append(op1)
    elsif goalX > startX
        op1 = "^" * (startY - goalY) + ">" * (goalX - startX)
        op2 = ">" * (goalX - startX) + "^" * (startY - goalY)
        if not (startX == 0 and goalY == 0 and locations == 5)
          shortest.append(op1)
        end
        shortest.append(op2)
    else
      shortest.append("^" * (startY - goalY))
    end
  else
    if startX > goalX
        op1 = "v" * (goalY - startY) + "<" * (startX - goalX)
        op2 = "<" * (startX - goalX) + "v" * (goalY - startY)
        if not (goalX == 0 and startY == 0 and locations == 5)
          shortest.append(op2)
        end
        shortest.append(op1)
    elsif goalX > startX
        op1 = "v" * (goalY - startY) + ">" * (goalX - startX)
        op2 = ">" * (goalX - startX) + "v" * (goalY - startY)
        if not (startX == 0 and goalY == 3 and locations == 11)
          shortest.append(op1)
        end
        shortest.append(op2)
    else
      shortest.append("v" * (goalY - startY))
    end
  end

  memo[[start, goal, locations]] = shortest.map { |i| i + "A"}
  return shortest.map { |i| i + "A"}
  
end

def getBestPaths(toTry, locMap, locs, memo1)
    nextBP = []

    for path in toTry

      bestPaths = [""]
      path = "A" + path
      for c in 0...(path.length - 1)
          char = path[c]
          if /\d/.match? char
              char = char.to_i
          end
          nextChar = path[c + 1]
          if /\d/.match? nextChar
              nextChar = nextChar.to_i
          end

          paths = getAllShortest(locMap[char], locMap[nextChar], memo1, locs.size)

          newPaths = []
          for b in bestPaths
              for p in paths
                  newPaths.append(b + p)
              end
          end
          bestPaths = newPaths
      end
      nextBP += bestPaths
    end

    minLen = nextBP.min { |i, j| i.length <=> j.length }.length
    nextBP.delete_if { |i| i.length != minLen }
    return nextBP
end

def decoder(start, path, locs)
  message = ""
  for i in path.split("")
    if i == "<"
      start[1] -= 1
    end
    if i == ">"
      start[1] += 1
    end
    if i == "v"
      start[0] += 1
    end
    if i == "^"
      start[0] -= 1
    end
    if i == "A"
      message += locs[start].to_s
    end
  end
  return message
end


def part1(input)
    keypad = {
        [0, 0] => 7,
        [0, 1] => 8,
        [0, 2] => 9,
        [1, 0] => 4,
        [1, 1] => 5,
        [1, 2] => 6,
        [2, 0] => 1,
        [2, 1] => 2,
        [2, 2] => 3,
        [3, 1] => 0,
        [3, 2] => "A",
    }

    reverseKeypad = {}
    for i in keypad.keys
      reverseKeypad[keypad[i]] = i
    end

    keypadSet = keypad.keys.to_set

    directions = {
        [0, 1] => "^",
        [0, 2] => "A",
        [1, 0] => "<",
        [1, 1] => "v",
        [1, 2] => ">",
    }

    reverseDirections = {}

    for i in directions.keys
      reverseDirections[directions[i]] = i
    end

    directionSet = directions.keys.to_set


    memo1 = {}

    total = 0

    for line in input
      num = line.to_i

      toTry = [line]

      toTry = getBestPaths(toTry, reverseKeypad, keypadSet, memo1)

      
      toTry = getBestPaths(toTry, reverseDirections, directionSet, memo1)

      toTry = getBestPaths(toTry, reverseDirections, directionSet, memo1)

      total += toTry[0].length * num

    end

    return total
end

def getAShortestPath(start, goal, depth, memo, m1, reverseDirections)
  if memo[[start, goal, depth]]
    return memo[[start, goal, depth]]
  end
  if depth == 1
    possible = getAllShortest(start, goal, m1, 5)
    memo[[start, goal, depth]] = possible[0].length
    return possible[0].length
  end

  options = getAllShortest(start, goal, m1, 5)
  bestLen = Float::INFINITY
  for path in options
    thisLen = 0
    path = "A" + path
    for c in 0...(path.length - 1)
        char = path[c]
        if /\d/.match? char
            char = char.to_i
        end
        nextChar = path[c + 1]
        if /\d/.match? nextChar
            nextChar = nextChar.to_i
        end
        thisLen += getAShortestPath(reverseDirections[char], reverseDirections[nextChar], depth - 1, memo, m1, reverseDirections)
    end

    bestLen = [thisLen, bestLen].min
  end

  memo[[start, goal, depth]] = bestLen
  return bestLen
end

def part2(input)
    keypad = {
        [0, 0] => 7,
        [0, 1] => 8,
        [0, 2] => 9,
        [1, 0] => 4,
        [1, 1] => 5,
        [1, 2] => 6,
        [2, 0] => 1,
        [2, 1] => 2,
        [2, 2] => 3,
        [3, 1] => 0,
        [3, 2] => "A",
    }

    reverseKeypad = {}
    for i in keypad.keys
      reverseKeypad[keypad[i]] = i
    end

    keypadSet = keypad.keys.to_set

    directions = {
        [0, 1] => "^",
        [0, 2] => "A",
        [1, 0] => "<",
        [1, 1] => "v",
        [1, 2] => ">",
    }

    reverseDirections = {}

    for i in directions.keys
      reverseDirections[directions[i]] = i
    end


    memo1 = {}

    recurseMemo = {}

    total = 0

    depth = 25

    for line in input
      num = line.to_i

      toTry = [line]

      firstBest = getBestPaths(toTry, reverseKeypad, keypadSet, memo1)
      
      bestLen = Float::INFINITY
      for path in firstBest
        thisLen = 0
        path = "A" + path
        for c in 0...(path.length - 1)
            char = path[c]
            if /\d/.match? char
                char = char.to_i
            end
            nextChar = path[c + 1]
            if /\d/.match? nextChar
                nextChar = nextChar.to_i
            end
            thisLen += getAShortestPath(reverseDirections[char], reverseDirections[nextChar], depth, recurseMemo, memo1, reverseDirections)
        end
        bestLen = [thisLen, bestLen].min
      end

      total += bestLen * num

    end

    return total
end

puts part1(data)
puts part2(data)