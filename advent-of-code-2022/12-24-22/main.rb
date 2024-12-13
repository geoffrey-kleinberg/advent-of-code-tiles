fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def getValidNeighbors(cur, snowMap)
  neighbors = []
  for i in -1..1
    for j in -1..1
      next if [-1, 1].include? i and [-1, 1].include? j
      if snowMap[[cur[0] + i, cur[1] + j]] == "o"
        neighbors << [cur[0] + i, cur[1] + j]
      end
    end
  end
  return neighbors
end

def getMDistance(l1, l2)
  return (l1[0] - l2[0]).abs + (l1[1] - l2[1]).abs
end

def updateSnow(snowMap, rMax, cMax)
  newMap = {}
  for i in snowMap.keys
    if snowMap[i] == "w"
      newMap[i] = "w"
    elsif snowMap[i] == "o"
      if not newMap[i]
        newMap[i] = []
      end
    else
      if not newMap[i]
        newMap[i] = []
      end
      for b in snowMap[i]
        nextLoc = []
        if b == ">"
          nextLoc = [i[0], i[1] + 1]
          if snowMap[nextLoc] == "w"
            nextLoc = [i[0], 1]
          end
        elsif b == "<"
          nextLoc = [i[0], i[1] - 1]
          if snowMap[nextLoc] == "w"
            nextLoc = [i[0], rMax]
          end
        elsif b == "v"
          nextLoc = [i[0] + 1, i[1]]
          if snowMap[nextLoc] == "w"
            nextLoc = [1, i[1]]
          end
        elsif b == "^"
          nextLoc = [i[0] - 1, i[1]]
          if snowMap[nextLoc] == "w"
            nextLoc = [cMax, i[1]]
          end
        else
          puts b
          raise 'b'
        end
        if not newMap[nextLoc]
          newMap[nextLoc] = []
        end
        newMap[nextLoc].append(b)
      end
    end
  end
  for i in newMap.keys
    if newMap[i].length == 0
      newMap[i] = "o"
    end
  end
  return newMap
end

def part1(input)
  snowMap = {}
  pos = [0, 1]
  for i in 0...input.length
    for j in 0...input[i].length
      if input[i].slice(j) == "#"
        snowMap[[i, j]] = "w"
      elsif input[i].slice(j) == "."
        snowMap[[i, j]] = "o"
      else
        snowMap[[i, j]] = [input[i].slice(j)]
      end
    end
  end
  rMin = 1
  rMax = input[0].length - 2
  cMin = 1
  cMax = input.length - 2
  # puts rMax
  # puts cMax
  goal = [cMax + 1, rMax]
  shortest = { pos => 0 }
  queue = { getMDistance(pos, goal) => [pos] }
  snowMaps = { -1 => snowMap.clone }
  rep = 0
  while true
    minDist = queue.keys.min
    minList = queue[minDist]
    cur = minList[0]
    steps = shortest[cur]
    if cur == [cMax + 1, rMax]
      return shortest[cur]
    end
    time = minDist - getMDistance(cur, goal)
    snowMap = {}
    # print cur
#     puts
#     puts time
#     puts steps
    if snowMaps[time]
      snowMap = snowMaps[time]
    elsif snowMaps[time - 1]
      snowMap = updateSnow(snowMaps[time - 1], rMax, cMax)
      snowMaps[time] = snowMap.clone
    else
      raise 'what'
    end
    possible = getValidNeighbors(cur, snowMap)
    # print possible
    # puts
    for i in possible
      if shortest[i]
        if shortest[i] > time
          shortest[i] = time + 1
        end
      else
        shortest[i] = time + 1
      end
      # puts shortest[i]
      d = getMDistance(i, goal)
      # print i
#       puts
#       puts d
      if not queue[time + 1 + d]
        queue[time + 1 + d] = []
      end
      if not queue[time + 1 + d].include? i
        queue[time + 1 + d].append(i)
      end
    end
    minList.delete_at(0)
    if minList.length == 0
      queue.delete(minDist)
    end
    # print queue
    # puts
    # puts
    # puts
    rep += 1
    #break if rep == 6
    #break
  end
  print shortest
  puts
end

def part2(input)
  snowMap = {}
  pos = [0, 1]
  for i in 0...input.length
    for j in 0...input[i].length
      if input[i].slice(j) == "#"
        snowMap[[i, j]] = "w"
      elsif input[i].slice(j) == "."
        snowMap[[i, j]] = "o"
      else
        snowMap[[i, j]] = [input[i].slice(j)]
      end
    end
  end
  rMin = 1
  rMax = input[0].length - 2
  cMin = 1
  cMax = input.length - 2
  # puts rMax
  # puts cMax
  goal = [cMax + 1, rMax]
  shortest = { pos => 0 }
  queue = { getMDistance(pos, goal) => [pos] }
  snowMaps = { -1 => snowMap.clone }
  rep = 0
  firstTrip = 373
  # while true
#     minDist = queue.keys.min
#     minList = queue[minDist]
#     cur = minList[0]
#     steps = shortest[cur]
#     if cur == goal
#       firstTrip = shortest[cur]
#       break
#     end
#     time = minDist - getMDistance(cur, goal)
#     snowMap = {}
#     # print cur
# #     puts
#     # puts time
# #     puts steps
#     if snowMaps[time]
#       snowMap = snowMaps[time]
#     elsif snowMaps[time - 1]
#       snowMap = updateSnow(snowMaps[time - 1], rMax, cMax)
#       snowMaps[time] = snowMap.clone
#     else
#       raise 'what'
#     end
#     possible = getValidNeighbors(cur, snowMap)
#     # print possible
#     # puts
#     for i in possible
#       if shortest[i]
#         if shortest[i] > time
#           shortest[i] = time + 1
#         end
#       else
#         shortest[i] = time + 1
#       end
#       # puts shortest[i]
#       d = getMDistance(i, goal)
#       # print i
# #       puts
# #       puts d
#       if not queue[time + 1 + d]
#         queue[time + 1 + d] = []
#       end
#       if not queue[time + 1 + d].include? i
#         queue[time + 1 + d].append(i)
#       end
#     end
#     minList.delete_at(0)
#     if minList.length == 0
#       queue.delete(minDist)
#     end
#     # print queue
#     # puts
#     # puts
#     # puts
#     rep += 1
#     #break if rep == 6
#     #break
#   end
  puts firstTrip
  for i in 0..firstTrip
    snowMaps[i] = updateSnow(snowMaps[i - 1], rMax, cMax)
  end
  pos = [cMax + 1, rMax]
  goal = [0, 1]
  shortest = { pos => firstTrip }
  queue = { getMDistance(pos, goal) => [pos] }
  secondTrip = 0
  while true
    minDist = queue.keys.min
    minList = queue[minDist]
    cur = minList[0]
    steps = shortest[cur]
    if cur == goal
      secondTrip = shortest[cur]
      break
    end
    time = minDist - getMDistance(cur, goal)
    snowMap = {}
    # print cur
    # puts
    # puts time
    # puts
#     puts steps
    if snowMaps[time + firstTrip]
      snowMap = snowMaps[time + firstTrip]
    elsif snowMaps[time - 1 + firstTrip]
      snowMap = updateSnow(snowMaps[time - 1 + firstTrip], rMax, cMax)
      snowMaps[time + firstTrip] = snowMap.clone
    else
      raise 'what'
    end
    possible = getValidNeighbors(cur, snowMap)
    # print possible
    # puts
    for i in possible
      if shortest[i]
        if shortest[i] > time
          shortest[i] = time + 1
        end
      else
        shortest[i] = time + 1
      end
      # puts shortest[i]
      d = getMDistance(i, goal)
      # print i
#       puts
#       puts d
      if not queue[time + 1 + d]
        queue[time + 1 + d] = []
      end
      if not queue[time + 1 + d].include? i
        queue[time + 1 + d].append(i)
      end
    end
    minList.delete_at(0)
    if minList.length == 0
      queue.delete(minDist)
    end
    # print queue
    # puts
    # puts
    # puts
    rep += 1
    #break if rep == 6
    #break
  end
  puts secondTrip
  goal = [cMax + 1, rMax]
  pos = [0, 1]
  shortest = { pos => firstTrip + secondTrip }
  queue = { getMDistance(pos, goal) => [pos] }
  thirdTrip = 0
  while true
    minDist = queue.keys.min
    minList = queue[minDist]
    cur = minList[0]
    steps = shortest[cur]
    if cur == goal
      return firstTrip + secondTrip + shortest[cur]
    end
    time = minDist - getMDistance(cur, goal)
    snowMap = {}
    # print cur
    # puts
    # puts time
    # puts
#     puts steps
    if snowMaps[time + firstTrip + secondTrip]
      snowMap = snowMaps[time + firstTrip + secondTrip]
    elsif snowMaps[time - 1 + firstTrip + secondTrip]
      snowMap = updateSnow(snowMaps[time - 1 + firstTrip + secondTrip], rMax, cMax)
      snowMaps[time + firstTrip + secondTrip] = snowMap.clone
    else
      raise 'what'
    end
    possible = getValidNeighbors(cur, snowMap)
    # print possible
    # puts
    for i in possible
      if shortest[i]
        if shortest[i] > time
          shortest[i] = time + 1
        end
      else
        shortest[i] = time + 1
      end
      # puts shortest[i]
      d = getMDistance(i, goal)
      # print i
#       puts
#       puts d
      if not queue[time + 1 + d]
        queue[time + 1 + d] = []
      end
      if not queue[time + 1 + d].include? i
        queue[time + 1 + d].append(i)
      end
    end
    minList.delete_at(0)
    if minList.length == 0
      queue.delete(minDist)
    end
    # print queue
    # puts
    # puts
    # puts
    rep += 1
    #break if rep == 6
    #break
  end
  puts secondTrip
end

#puts part1(data)
puts part2(data)