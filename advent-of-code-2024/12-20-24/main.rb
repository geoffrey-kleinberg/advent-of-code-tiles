require 'set'

day = "20"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def manhattan(a, b)
  return (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

def aStar(start, goal, walls, memo)
  if walls.include? start
    memo[start] = Float::INFINITY
    return Float::INFINITY
  end
  if memo[start]
    return memo[start]
  end
  seen = Set[start]
  queue = {
    manhattan(start, goal) => [[[start], 0]]
  }

  while queue.size > 0
    quickest = queue.keys.min
    cur = queue[quickest].shift
    curPath = cur[0]
    curLoc = curPath.last
    if queue[quickest].length == 0
      queue.delete(quickest)
    end
    if memo[curLoc]
      return memo[curLoc]
    end
    curDist = cur[1]
    if curLoc == goal
      for i in 0...curPath.length
        memo[curPath[i].clone] = curDist - i
      end
      return curDist
    end

    for d in [[1, 0], [0, 1], [-1, 0], [0, -1]]
      nextLoc = [curLoc[0] + d[0], curLoc[1] + d[1]]
      next if seen.include? nextLoc
      next if walls.include? nextLoc
      seen.add(nextLoc)

      heuristic = curDist + 1 + manhattan(nextLoc, goal)

      newPath = curPath + [nextLoc]

      if not queue[heuristic]
        queue[heuristic] = []
      end
      queue[heuristic].append([newPath, curDist + 1])
    end
  end
  memo[start] = Float::INFINITY
  return Float::INFINITY
end

def cheatStar(start, goal, walls, toBeat, yMax, xMax, noCheatFastest)
  cheats = {}

  seen = Set[start]
  queue = {
    manhattan(start, goal) => [[Set[start], 0, false, start]]
  }

  maxIter = 10
  iter = 0

  while queue.keys.size > 0
    # if iter >= maxIter
    #   break
    # end
    iter += 1
    quickest = queue.keys.min
    cur = queue[quickest].shift
    curPath = cur[0]
    curDist = cur[1]
    cheat = cur[2]
    curLoc = cur[3]
    if queue[quickest].length == 0
      queue.delete(quickest)
    end
    if curLoc == goal
      cheats[cheat] = curDist
      next
    end
    if cheat and not curLoc == cheat
      if not noCheatFastest[curLoc]
        aStar(curLoc, goal, walls, noCheatFastest)
      end
    #   print noCheatFastest
    #   puts
    #   print curLoc
    #   puts
      cheats[cheat] = curDist + noCheatFastest[curLoc] - 1
      next
    end

    for d in [[1, 0], [0, 1], [-1, 0], [0, -1]]
      cheat = cur[2]
      nextLoc = [curLoc[0] + d[0], curLoc[1] + d[1]]
      if nextLoc[0] < 0 or nextLoc[1] < 0 or nextLoc[0] >= yMax or nextLoc[1] >= xMax
        next
      end
      next if curPath.include? nextLoc

      if walls.include? nextLoc
        next if cheat
        next if cheats[nextLoc]
        cheat = nextLoc.clone
      end

      heuristic = curDist + 1 + manhattan(nextLoc, goal)
      next if heuristic >= toBeat - 100

      newPath = curPath + Set[nextLoc]

      if not queue[heuristic]
        queue[heuristic] = []
      end
      queue[heuristic].append([newPath, curDist + 1, cheat, nextLoc])
    end
    # print queue
    # puts
  end

  return cheats
end

def countCheats(start, goal, walls, toBeat, yMax, xMax, noCheatFastest, cheatDist=20, timeSave=100)
    cheats = 0
  
    queue = {
      manhattan(start, goal) => [[Set[start], 0, start]]
    }

    while queue.keys.size > 0
      quickest = queue.keys.min
      cur = queue[quickest].shift
      curPath = cur[0]
      curDist = cur[1]
      curLoc = cur[2]
      if queue[quickest].length == 0
        queue.delete(quickest)
      end
      if curLoc == goal
        return cheats
      end

      for dy in (-1 * cheatDist)..(cheatDist)
        dxMax = cheatDist - dy.abs
        for dx in (-1 * dxMax)..(dxMax)
          cheatTo = [curLoc[0] + dy, curLoc[1] + dx]
          next if walls.include? cheatTo
          if cheatTo[0] < 0 or cheatTo[1] < 0 or cheatTo[0] >= yMax or cheatTo[1] >= xMax
            next
          end
          aStar(cheatTo, goal, walls, noCheatFastest)
          totalDist = curDist + manhattan(curLoc, cheatTo) + noCheatFastest[cheatTo]
          if totalDist <= toBeat - timeSave
            cheats += 1
          end
        end
      end
  
      for d in [[1, 0], [0, 1], [-1, 0], [0, -1]]
        nextLoc = [curLoc[0] + d[0], curLoc[1] + d[1]]
  
        next if walls.include? nextLoc
        next if curPath.include? nextLoc
  
        heuristic = curDist + 1 + manhattan(nextLoc, goal)
        next if heuristic > toBeat - timeSave
  
        newPath = curPath + Set[nextLoc]
  
        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append([newPath, curDist + 1, nextLoc])
      end
    end
  
    return cheats
end

def part1(input)
  
    start = nil
    goal = nil
    walls = Set[]
    for i in 0...input.length
      for j in 0...input[i].length
        if input[i][j] == "S"
          start = [i, j]
        #   input[i][j] = "."
        end
        if input[i][j] == "E"
          goal = [i, j]
        #   input[i][j] = "."
        end
        if input[i][j] == "#"
          walls.add([i, j])
        end
      end
    end

    memo = {}

    minDist = aStar(start, goal, walls, memo)

    # puts minDist

    # cheatList = cheatStar(start, goal, walls, minDist, input.length, input[0].length, memo)

    # # print cheatList
    # # puts

    # good = 0

    # for i in cheatList.keys
    #   if minDist - cheatList[i] >= 100
    #     good += 1
    #   end
    # end

    # return good
    # 
    return countCheats(start, goal, walls, minDist, input.length, input[0].length, memo, cheatDist=2, timeSave=100)
end

def cheatStar2(start, goal, walls, toBeat, yMax, xMax, noCheatFastest)
    cheats = {}
  
    queue = {
      manhattan(start, goal) => [[Set[start], 0, "unused", start, nil, nil, 0]]
    }


    # path, dist, cheatUsed, curNode, cheatStart, cheatEnd, cheatLen
  
    maxIter = 20000
    iter = 0

    while queue.keys.size > 0
    #   if iter >= maxIter
    #     break
    #   end
    #   iter += 1
      quickest = queue.keys.min
      cur = queue[quickest].shift
      curPath = cur[0]
      curDist = cur[1]
      cheat = cur[2]
      curLoc = cur[3]
      cheatStart = cur[4]
      cheatEnd = cur[5]
      cheatLen = cur[6]
      if queue[quickest].length == 0
        queue.delete(quickest)
      end
      if cheat == "done"
        if walls.include? curLoc
          cheats[[cheatStart, cheatEnd]] = Float::INFINITY
        else
            if not noCheatFastest[curLoc]
                aStar(curLoc, goal, walls, noCheatFastest)
            end
            # print noCheatFastest
            # puts
            # print curLoc
            # puts
            if (not cheats[[cheatStart, cheatEnd]]) or (curDist + noCheatFastest[curLoc] - 1 < cheats[[cheatStart, cheatEnd]])
                cheats[[cheatStart, cheatEnd]] = curDist + noCheatFastest[curLoc]
            end
        end
        next
      end
      if curLoc == goal
        if cheat == "done" or cheat == "in progress"
            if cheatStart == [3, 1]
              puts "here"
            end
            cheats[[cheatStart, goal]] = curDist
        end
        next
      end
  
      for d in [[1, 0], [0, 1], [-1, 0], [0, -1]]
        cheatStart = cur[4]
        cheatEnd = cur[5]
        cheatLen = cur[6]
        cheat = cur[2]
        nextLoc = [curLoc[0] + d[0], curLoc[1] + d[1]]
        if nextLoc[0] < 0 or nextLoc[1] < 0 or nextLoc[0] >= yMax or nextLoc[1] >= xMax
          next
        end
  
        if walls.include? nextLoc
          if cheat == "done"
            raise "I don't think this should happen"
          end
          next if cheatLen >= 20
          if cheat == "unused"
            cheatStart = curLoc
            # nextCheatEnd = nextLoc
            cheatLen = 1
            cheat = "in progress"
          elsif cheat == "in progress"
            # nextCheatEnd = nextLoc
            # nextCheatStart = cheatStart
            cheatLen = cheatLen + 1
            # nextCheat = "in progress"
          end
        elsif cheat == "in progress"
          cheat = "done"
          cheatEnd = nextLoc
          cheatLen = cheatLen
        end
        next if curPath.include? nextLoc
  
        heuristic = curDist + 1 + manhattan(nextLoc, goal)
        aStar(nextLoc, goal, walls, noCheatFastest)
        if cheat == "done"
          heuristic = curDist + noCheatFastest[nextLoc]
        end
        next if heuristic > toBeat - 50
  
        newPath = curPath + Set[nextLoc]
  
        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append([newPath, curDist + 1, cheat, nextLoc, cheatStart, cheatEnd, cheatLen])
      end
    #   print queue
    #   puts
    end
  
    return cheats
end

def part2(input)
    start = nil
    goal = nil
    walls = Set[]
    for i in 0...input.length
      for j in 0...input[i].length
        if input[i][j] == "S"
          start = [i, j]
        #   input[i][j] = "."
        end
        if input[i][j] == "E"
          goal = [i, j]
        #   input[i][j] = "."
        end
        if input[i][j] == "#"
          walls.add([i, j])
        end
      end
    end

    memo = {}

    minDist = aStar(start, goal, walls, memo)

    return countCheats(start, goal, walls, minDist, input.length, input[0].length, memo, cheatDist=20, timeSave=100)
end

puts part1(data)

puts part2(data)