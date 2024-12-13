require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def getGeodes(blueprint, materials, robots, time, memo)
  if memo[[materials, robots, time]]
    return memo[[materials, robots, time]]
  end
  if time == 0
    return materials[3]
  end
  nextMaterials = materials.clone
  for i in 0...4
    nextMaterials[i] += robots[i]
  end
  possibleSpends = []
  oreCosts = [blueprint[0], blueprint[1], blueprint[2][0], blueprint[3][0]]
  if materials[0] >= blueprint[0] and oreCosts.any? { |i| i > robots[0] }
    if not materials[0] >= oreCosts.max * time
      nextRobots = robots.clone
      nextRobots[0] += 1
      nextMaterials[0] -= blueprint[0]
      buildOre = getGeodes(blueprint, nextMaterials, nextRobots, time - 1, memo)
      nextMaterials[0] += blueprint[0]
      possibleSpends.append(buildOre)
    end
  end
  if materials[0] >= blueprint[1] and blueprint[2][1] > robots[1]
    if not materials[1] >= blueprint[2][1] * time
      nextRobots = robots.clone
      nextRobots[1] += 1
      nextMaterials[0] -= blueprint[1]
      buildClay = getGeodes(blueprint, nextMaterials, nextRobots, time - 1, memo)
      nextMaterials[0] += blueprint[1]
      possibleSpends.append(buildClay)
    end
  end
  if materials[0] >= blueprint[2][0] and materials[1] >= blueprint[2][1] and blueprint[3][1] > robots[2]
    if not materials[2] >= blueprint[3][1] * time
      nextRobots = robots.clone
      nextRobots[2] += 1
      nextMaterials[0] -= blueprint[2][0]
      nextMaterials[1] -= blueprint[2][1]
      buildOb = getGeodes(blueprint, nextMaterials, nextRobots, time - 1, memo)
      nextMaterials[0] += blueprint[2][0]
      nextMaterials[1] += blueprint[2][1]
      possibleSpends.append(buildOb)
    end
  end
  if materials[0] >= blueprint[3][0] and materials[2] >= blueprint[3][1]
    nextRobots = robots.clone
    nextRobots[3] += 1
    nextMaterials[0] -= blueprint[3][0]
    nextMaterials[2] -= blueprint[3][1]
    buildGe = getGeodes(blueprint, nextMaterials, nextRobots, time - 1, memo)
    nextMaterials[0] += blueprint[3][0]
    nextMaterials[2] += blueprint[3][1]
    possibleSpends.append(buildGe)
  end
  noBuild = getGeodes(blueprint, nextMaterials, robots, time - 1, memo)
  possibleSpends.append(noBuild)
  memo[[materials, robots, time]] = possibleSpends.max
  return memo[[materials, robots, time]]
end

def part1(input)
  blueprints = []
  for i in input
    splitVersion = i.split("costs ")
    oreCost = splitVersion[1].split(" ")[0].to_i
    clayCost = splitVersion[2].split(" ")[0].to_i
    obCost = [splitVersion[3].split(" ")[0].to_i]
    obCost.append(splitVersion[3].split("and ")[1].split(" ")[0].to_i)
    geoCost = [splitVersion[4].split(" ")[0].to_i]
    geoCost.append(splitVersion[4].split("and ")[1].split(" ")[0].to_i)
    blueprints << [oreCost, clayCost, obCost, geoCost]
  end
  totalScore = 0
  for i in 0...blueprints.length
    curr = blueprints[i]
    
    num = i + 1
    a = {}
    #bestCollection = getGeodes(curr, [4, 33, 4, 5], [1, 4, 2, 2], 2, {})
    #bestCollection = getGeodes(curr, [4, 25, 7, 2], [1, 4, 2, 1], 4, {})
    #bestCollection = getGeodes(curr, [3, 29, 2, 3], [1, 4, 2, 2], 3, {})
    #bestCollection = getGeodes(curr, [4, 15, 0, 0], [1, 3, 0, 0], 14, a)
    #puts a.size
    t = Time.now
    bestCollection = getGeodes(curr, [0, 0, 0, 0], [1, 0, 0, 0], 24, {})
    puts Time.now - t
    puts bestCollection
    #print bestCollection
    #puts
    #break
    totalScore += num * bestCollection
  end
  return totalScore
end

def getTriangle(n)
  return (n * (n - 1)) / 2
end

def getBestPossible(materials, robots, time)
  alreadyHave = materials[3]
  currentRate = robots[3] * time
  subtract = 1
  if robots[1] == 0
    subtract += 1
  end
  if robots[2] == 0
    subtract += 1
  end
  possible = (time - subtract >= 0) ? getTriangle(time - subtract) : 0
  return alreadyHave + currentRate + possible
end

def getLoc(nums, num)
  if nums.length == 0
    return 0
  end
  if nums.length == 1
    return (num > nums[0]) ? 0 : 1
  end
  l = nums.length
  half = l / 2
  median = nums[half]
  if median == num
    return half
  elsif median < num
    return getLoc(nums.first(half), num)
  else
    return half + getLoc(nums.last(half + (l % 2)), num)
  end
end

def getLoc2(pairs, pair)
  if pairs.length == 0
    return 0
  end
  if pairs.length == 1
    if pair[0] == pairs[0][0]
      return (pair[1] < pairs[0][1]) ? 0 : 1
    else
      return (pair[0] > pairs[0][0]) ? 0 : 1
    end
  end
  l = pairs.length
  half = l / 2
  medians = pairs[half]
  if medians[0] == pair[0]
    if medians[1] == pair[1]
      return half
    elsif medians[1] < pair[1]
      return half + getLoc2(pairs.last(half + (l % 2)), pair)
    else
      return getLoc2(pairs.first(half), pair)
    end
  elsif medians[0] < pair[0]
    return getLoc2(pairs.first(half), pair)
  else
    return half + getLoc2(pairs.last(half + (l % 2)), pair)
  end
end

def bInsert(queue, toInsert, vals)
  valueQueue = queue.map { |i| vals[i.to_s] }
  bLocation = getLoc(valueQueue, vals[toInsert.to_s] )
  queue.insert(bLocation, toInsert)
end

def bInsert2(queue, toInsert, vals)
  valueQueue = queue.map { |i| [vals[i.to_s], i[2]] }
  bLocation = getLoc2(valueQueue, [vals[toInsert.to_s], toInsert[2]])
  queue.insert(bLocation, toInsert)
end

def aStarSolve(blueprint, tTime)
  #materials, robots, time
  first = [[0, 0, 0, 0], [1, 0, 0, 0], tTime]
  #first = [[2, 11, 2, 0], [1, 4, 1, 0], 11]
  #first = [[1, 5, 4, 0], [1, 4, 2, 0], 9]
  #first = [[3, 13, 8, 0], [1, 4, 2, 0], 7]
  #first = [[4, 25, 7, 2], [1, 4, 2, 1], 4]
  #first = [[4, 33, 4, 5], [1, 4, 2, 2], 2]
  #distance = {first => 0}
  times = Set[tTime]
  actualBest = 0
  hDists = { first.to_s => getBestPossible(first[0], first[1], first[2]) }
  queue = [first]
  reps = 1
  maxOre = [blueprint[0], blueprint[1], blueprint[2][0], blueprint[3][0]].max
  maxClay = blueprint[2][1]
  maxOb = blueprint[3][1]
  best = -1
  sortTime = 0
  t = Time.now
  while queue.length > 0
    curr = queue[0]
    queue.delete_at(0)
    #if curr[2] > times.min
    #  queue.delete_at(0)
    ##  next
    #end
    #if times.add? (curr[2])
    #  puts Time.now - t
    #  puts queue.length
    #  puts sortTime
    #  sortTime = 0
    #  puts curr[2]
    #  puts
    #  t = Time.now
    #end
    actualBest = [actualBest, (curr[0][3] + curr[1][3] * curr[2])].max
    if curr[2] == 0
      best = [best, curr[0][3]].max
      next
      #return hDists[curr.to_s]
    end
    #add "make nothing the rest of the time" to the queue
    copy = curr.clone
    copy = copy.map { |i| i.clone }
    copy[2] = 0
    for i in 0...4
      copy[0][i] += curr[2] * curr[1][i]
    end
    if not hDists[copy.to_s]
      hDists[copy.to_s] = getBestPossible(copy[0], copy[1], copy[2])
      if not hDists[copy.to_s] < actualBest
        t1 = Time.now
        #bInsert2(queue, copy, hDists)
        queue.append(copy)
        sortTime += Time.now - t1
      end
    end
    #add "make ore robot ASAP" if possible (always) and necessary
    if curr[1][0] < maxOre and not curr[0][0] >= maxOre * curr[2]
      copy = curr.clone
      copy = copy.map { |i| i.clone }
      time = ((blueprint[0] - curr[0][0]) / curr[1][0].to_f).ceil + 1
      time = [time, 1].max
      if curr[2] - time >= 0
        for i in 0...4
          copy[0][i] += time * curr[1][i]
        end
        copy[0][0] -= blueprint[0]
        copy[1][0] += 1
        copy[2] -= time
        if not hDists[copy.to_s] 
          hDists[copy.to_s] = getBestPossible(copy[0], copy[1], copy[2])
          if not hDists[copy.to_s] < actualBest
            t1 = Time.now
            #bInsert2(queue, copy, hDists)
            queue.append(copy)
            sortTime += Time.now - t1
          end
        end
      end
    end
    if curr[1][1] < maxClay and not curr[0][1] >= maxClay * curr[2]
      #add "make clay robot ASAP" if possble (always) and necessary
      copy = curr.clone
      copy = copy.map { |i| i.clone }
      time = ((blueprint[1] - curr[0][0]) / curr[1][0].to_f).ceil + 1
      time = [time, 1].max
      if curr[2] - time >= 0
        for i in 0...4
          copy[0][i] += time * curr[1][i]
        end
        copy[0][0] -= blueprint[1]
        copy[1][1] += 1
        copy[2] -= time
        if not hDists[copy.to_s]
          hDists[copy.to_s] = getBestPossible(copy[0], copy[1], copy[2])
          if not hDists[copy.to_s] < actualBest
            t1 = Time.now
            #bInsert2(queue, copy, hDists)
            queue.append(copy)
            sortTime += Time.now - t1
          end
        end
      end
    end
    #add "make obsidian robot ASAP" if possible (if have at least 1 clay robot) and necessary
    if curr[1][1] != 0 and curr[1][2] < maxOb and not curr[0][2] >= maxOb * curr[2]
      copy = curr.clone
      copy = copy.map { |i| i.clone }
      time1 = ((blueprint[2][0] - curr[0][0]) / curr[1][0].to_f).ceil + 1
      time2 = ((blueprint[2][1] - curr[0][1]) / curr[1][1].to_f).ceil + 1
      time = [time1, time2, 1].max
      if curr[2] - time >= 0
        for i in 0...4
          copy[0][i] += time * curr[1][i]
        end
        copy[0][0] -= blueprint[2][0]
        copy[0][1] -= blueprint[2][1]
        copy[1][2] += 1
        copy[2] -= time
        if not hDists[copy.to_s]
          hDists[copy.to_s] = getBestPossible(copy[0], copy[1], copy[2])
          if not hDists[copy.to_s] < actualBest
            t1 = Time.now
            #bInsert2(queue, copy, hDists)
            queue.append(copy)
            sortTime += Time.now - t1
          end
        end
      end
    end
    #add "make geode robot ASAP" if possible (if have at least 1 obsidian robot)
    if curr[1][2] != 0
      copy = curr.clone
      copy = copy.map { |i| i.clone }
      time1 = ((blueprint[3][0] - curr[0][0]) / curr[1][0].to_f).ceil + 1
      time2 = ((blueprint[3][1] - curr[0][2]) / curr[1][2].to_f).ceil + 1
      time = [time1, time2, 1].max
      if curr[2] - time >= 0
        for i in 0...4
          copy[0][i] += time * curr[1][i]
        end
        copy[0][0] -= blueprint[3][0]
        copy[0][2] -= blueprint[3][1]
        copy[1][3] += 1
        copy[2] -= time
        if not hDists[copy.to_s]
          hDists[copy.to_s] = getBestPossible(copy[0], copy[1], copy[2])
          if not hDists[copy.to_s] < actualBest
          #puts getBestPossible(copy[0], copy[1], copy[2])
            t1 = Time.now
            #bInsert2(queue, copy, hDists)
            queue.append(copy)
            sortTime += Time.now - t1
          end
        end
      end
    end
    #adding is always done such that queue is sorted by hDists (binary sorting)
    #with the highest hDist first
    #print queue
    #puts
    #break #if reps == 2
    reps += 1
    #if the current one has a time of 0, that is the best
  end
  return best
end

def part1b(input)
  blueprints = []
  for i in input
    splitVersion = i.split("costs ")
    oreCost = splitVersion[1].split(" ")[0].to_i
    clayCost = splitVersion[2].split(" ")[0].to_i
    obCost = [splitVersion[3].split(" ")[0].to_i]
    obCost.append(splitVersion[3].split("and ")[1].split(" ")[0].to_i)
    geoCost = [splitVersion[4].split(" ")[0].to_i]
    geoCost.append(splitVersion[4].split("and ")[1].split(" ")[0].to_i)
    blueprints << [oreCost, clayCost, obCost, geoCost]
  end
  totalScore = 0
  for i in 0...blueprints.length
    curr = blueprints[i]
    num = i + 1
    t = Time.now
    best = aStarSolve(curr, 24)
    puts best
    puts Time.now - t
    totalScore += num * best
  end
  return totalScore
end

def part2(input)
  blueprints = []
  for i in input
    splitVersion = i.split("costs ")
    oreCost = splitVersion[1].split(" ")[0].to_i
    clayCost = splitVersion[2].split(" ")[0].to_i
    obCost = [splitVersion[3].split(" ")[0].to_i]
    obCost.append(splitVersion[3].split("and ")[1].split(" ")[0].to_i)
    geoCost = [splitVersion[4].split(" ")[0].to_i]
    geoCost.append(splitVersion[4].split("and ")[1].split(" ")[0].to_i)
    blueprints << [oreCost, clayCost, obCost, geoCost]
  end
  totalScore = 1
  for i in 0...blueprints.length
    puts i
    curr = blueprints[i]
    
    num = i + 1
    a = {}
    #bestCollection = getGeodes(curr, [4, 33, 4, 5], [1, 4, 2, 2], 2, {})
    #bestCollection = getGeodes(curr, [4, 25, 7, 2], [1, 4, 2, 1], 4, {})
    #bestCollection = getGeodes(curr, [3, 29, 2, 3], [1, 4, 2, 2], 3, {})
    #bestCollection = getGeodes(curr, [4, 15, 0, 0], [1, 3, 0, 0], 14, a)
    #puts a.size
    t = Time.now
    bestCollection = getGeodes(curr, [0, 0, 0, 0], [1, 0, 0, 0], 32, {})
    puts Time.now - t
    puts i
    #print bestCollection
    #puts
    #break
    totalScore *= bestCollection
    break if i == 2
  end
  return totalScore
end

#9, 24  possible
def part2b(input)
  blueprints = []
  for i in input
    splitVersion = i.split("costs ")
    oreCost = splitVersion[1].split(" ")[0].to_i
    clayCost = splitVersion[2].split(" ")[0].to_i
    obCost = [splitVersion[3].split(" ")[0].to_i]
    obCost.append(splitVersion[3].split("and ")[1].split(" ")[0].to_i)
    geoCost = [splitVersion[4].split(" ")[0].to_i]
    geoCost.append(splitVersion[4].split("and ")[1].split(" ")[0].to_i)
    blueprints << [oreCost, clayCost, obCost, geoCost]
  end
  totalScore = 1
  for i in 0...blueprints.length
    #puts i
    curr = blueprints[i]
    num = i + 1
    t = Time.now
    best = aStarSolve(curr, 32)
    puts best
    #puts num
    puts Time.now - t
    totalScore *= best
    break if num == 3
  end
  return totalScore
end

puts part1b(data)
#puts part2(data)
puts part2b(data)