require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def getMaxFlow(rates, connections, openValves, current, toGo, flow)
  puts toGo if toGo > 20
  if toGo == 0
    return flow
  end
  nextValues = []
  totalFlow = openValves.to_a.inject(0) { |sum, i| rates[i] }
  if openValves.size == rates.size
    return flow + toGo * totalFlow
  end
  if not openValves.include? current
    openValves.add(current)
    nextValues << getMaxFlow(rates, connections, openValves.clone, current, toGo - 1, flow + totalFlow)
  end
  for i in connections[current]
    nextValues << getMaxFlow(rates, connections, openValves.clone, i, toGo - 1, flow + totalFlow)
  end
  return nextValues.max
end

def computeDist(i, j, connections)
  queue = [[[i]]]
  visited = Set[i]
  while true
    closest = 0
    while queue[closest].length == 0
      closest += 1
    end
    curr = queue[closest][0]
    lastNode = curr.last
    visited.add(lastNode)
    if lastNode == j
      return curr.length
    end
    for k in connections[lastNode]
      next if visited.include? k
      if not queue[closest + 1]
        queue[closest + 1] = []
      end
      newP = curr.clone
      newP.append(k)
      queue[closest + 1].append(newP)
    end
    queue[closest].delete_at(0)
  end
end

def makeDistMap(connections)
  distMap = {}
  for i in connections.keys
    for j in connections.keys
      d = computeDist(i, j, connections)
      if not distMap[i]
        distMap[i] = {}
      end
      distMap[i][j] = d
    end
  end
  return distMap
end

def getPressure(order, distMap, rates, minutes)
  pressure = 0
  for i in 0...order.length
    pressure += minutes * rates[order[i]]
    next if i == order.length - 1
    minutes -= distMap[order[i]][order[i + 1]]
  end
  return pressure
end

def solve(curr, minutes, unOpened, distMap, memo, order, rates)
  if memo[[curr, minutes, order]]
    return memo[[curr, minutes, order]]
  end
  if unOpened.size == 1
    thisO = order.clone
    thisO.append(unOpened[0])
    val = getPressure(thisO, distMap, rates, 30)
    memo[[curr, minutes, order]] = val
    return val
  end
  best = -1
  for i in unOpened
    if minutes - distMap[curr][i] < 0
      val = getPressure(order, distMap, rates, 30)
      memo[[curr, minutes, order]] = val
      return val
    end
    thisO = order.clone
    thisO.append(i)
    nextUn = unOpened.clone
    nextUn.delete(i)
    thisVal = solve(i, minutes - distMap[curr][i], nextUn, distMap, memo, thisO, rates)
    if thisVal > best
      best = thisVal
    end
  end
  memo[[curr, minutes, order]] = best
  return best
end

def s2(curr, minutes, unOpened, flow, rates, distMap, memo)
  if minutes <= 0
    return 0
  end
  if memo[[curr, minutes, unOpened]]
    return memo[[curr, minutes, unOpened]]
  end
  if unOpened.length == 1
    timeLeft = minutes - distMap[curr][unOpened[0]]
    if timeLeft <= 0
      return 0
    end
    val = rates[unOpened[0]] * (timeLeft)
    memo[[curr, minutes, unOpened]] = val
    return val
  end
  best = -1
  for i in unOpened
    timeLeft = minutes - distMap[curr][i]
    nextUn = unOpened.clone
    nextUn.delete(i)
    thisVal = (rates[i] * timeLeft) + s2(i, timeLeft, nextUn, (rates[i] * timeLeft), rates, distMap, memo)
    if timeLeft <= 0
      thisVal = 0
    end
    if thisVal > best
      best = thisVal
    end
  end
  memo[[curr, minutes, unOpened]] = best
  return best
end

def part1(input)
  start = "AA"
  valves = Set[]
  rates = {}
  connections = {}
  openValves = Set[]
  unOpened = []
  for i in input
    valve = i.split(" ")[1]
    valves.add(valve)
    rate = i.split("=")[1].split(";")[0].to_i
    if i.include? "valves"
      connection = i.split("valves ")[1].split(", ")
    else
      connection = i.split("valve ")[1].split(", ")
    end
    rates[valve] = rate
    if rate != 0
      unOpened.append(valve)
    end
    connections[valve] = connection
  end
  distMap = makeDistMap(connections)
  return s2("AA", 30, unOpened, 0, rates, distMap, {})
end

def s22(curr, minutes, unOpened, flow, rates, distMap, memo, memo2)
  if minutes <= 0
    return 0
  end
  if memo[[curr, minutes, unOpened]]
    return memo[[curr, minutes, unOpened]]
  end
  if unOpened.length == 1
    timeLeft = minutes - distMap[curr][unOpened[0]]
    if timeLeft <= 0
      return 0
    end
    val = rates[unOpened[0]] * (timeLeft)
    memo[[curr, minutes, unOpened]] = val
    return val
  end
  best = -1
  for i in unOpened
    timeLeft = minutes - distMap[curr][i]
    nextUn = unOpened.clone
    nextUn.delete(i)
    thisVal = (rates[i] * timeLeft) + s22(i, timeLeft, nextUn, (rates[i] * timeLeft), rates, distMap, memo, memo2)
    if timeLeft <= 0
      thisVal = 0
    end
    if thisVal > best
      best = thisVal
    end
  end
  other = s2("AA", 26, unOpened, 0, rates, distMap, memo2)
  if other > best
    best = other
  end
  memo[[curr, minutes, unOpened]] = best
  
return best

end

def getAllPaths(root, minutesRemaining, unOpened, distMap, memo)
  if memo[[root, minutesRemaining, unOpened]]
    return memo[[root, minutesRemaining, unOpened]]
  end
  if minutesRemaining < 0
    return []
  end
  subRoutes = []
  for i in unOpened
    lastVisit = root.last
    minR = minutesRemaining - distMap[lastVisit][i]
    newUn = unOpened.clone
    newUn.delete(i)
    thisSubR = getAllPaths(root + [i], minR, newUn, distMap, memo)
    subRoutes = subRoutes + thisSubR
  end
  memo[[root, minutesRemaining, unOpened]] = root + subRoutes
  return [root] + subRoutes
end

def pIntersection(p1, p2)
  return p1.clone.keep_if { |i| p2.include? i }
end

def goodInt(p1, p2)
  for i in p1
    next if i == "AA"
    if p2.include? i
      return false
    end
  end
  return true
end

#this is fairly fast
def part2(input)
  start = "AA"
  valves = Set[]
  rates = {}
  connections = {}
  openValves = Set[]
  unOpened = []
  for i in input
    valve = i.split(" ")[1]
    valves.add(valve)
    rate = i.split("=")[1].split(";")[0].to_i
    if i.include? "valves"
      connection = i.split("valves ")[1].split(", ")
    else
      connection = i.split("valve ")[1].split(", ")
    end
    rates[valve] = rate
    if rate != 0
      unOpened.append(valve)
    end
    connections[valve] = connection
  end
  distMap = makeDistMap(connections)
  return s22("AA", 26, unOpened, 0, rates, distMap, {}, {})
end

#2513 is too low
#this is old and slow
def part22(input, p1)
  start = "AA"
  valves = Set[]
  rates = {}
  connections = {}
  openValves = Set[]
  unOpened = []
  for i in input
    valve = i.split(" ")[1]
    valves.add(valve)
    rate = i.split("=")[1].split(";")[0].to_i
    if i.include? "valves"
      connection = i.split("valves ")[1].split(", ")
    else
      connection = i.split("valve ")[1].split(", ")
    end
    rates[valve] = rate
    if rate != 0
      unOpened.append(valve)
    end
    connections[valve] = connection
  end
  actualValves = unOpened.size
  distMap = makeDistMap(connections)
  allRoutes = getAllPaths(["AA"], 26, unOpened, distMap, {})
  puts allRoutes.length
  routeFlows = {}
  for i in allRoutes
    routeFlows[i] = getPressure(i, distMap, rates, 26)
  end
  puts routeFlows.size
  best = -1
  count = 0
  for me in 0...allRoutes.length
    puts me if me % 1000 == 0
    for el in me...allRoutes.length
      #next if allRoutes[me].length + allRoutes[el].length - 2 > actualValves
      #not a general solution but speeds up runtime dramatically
      #for general, replace below with commented line above
      next if allRoutes[me].length + allRoutes[el].length - 2 != actualValves - 2
      next if routeFlows[allRoutes[me]] + routeFlows[allRoutes[el]] < p1
      next if routeFlows[allRoutes[me]] + routeFlows[allRoutes[el]] < best
      if goodInt(allRoutes[me], allRoutes[el])
        flow = routeFlows[allRoutes[me]] + routeFlows[allRoutes[el]]
        if flow > best
          best = flow
          puts best
        end
      end
    end
    count += 1
  end
  return best
end

a = part1(data)
puts a
#puts part22(data, a)
t = Time.now
puts part2(data)
puts Time.now - t