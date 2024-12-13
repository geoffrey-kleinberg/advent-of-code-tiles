require "set"

def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def buildConnections(array)
  paths = {}
  for i in array
    if paths.has_key? i[0]
      paths[i[0]] << i[1]
    else
      paths[i[0]] = [i[1]]
    end
    if paths.has_key? i[1] and not i[1] == "end"
      paths[i[1]] << i[0]
    else
      paths[i[1]] = [i[0]]
    end
  end
  return paths
end

def isSmall(cave)
  lowercase = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  return cave.split("").all? { |i| lowercase.include? i }
end

def getAllRoutes(paths)
  unfinishedRoutes = [["start"]]
  finishedRoutes = []
  loop do
    newUnfinished = []
    for i in unfinishedRoutes
      toAdd = getChildPaths(i, paths)
      toAdd.each { |j| newUnfinished << j }
    end
    break if newUnfinished.length == 0
    unfinishedRoutes = newUnfinished.clone
    for i in unfinishedRoutes
      if i.slice(-1) == "end"
        finishedRoutes << i
      end
    end
  end
  return finishedRoutes
end

def getChildPaths(currPath, paths)
  newPaths = []
  last = currPath.slice(-1)
  gotNewPath = false
  for i in paths[last]
    next if isSmall(i) and currPath.include? i
    newPaths.append(currPath.clone.append(i))
    gotNewPath = true
  end
  return newPaths
end

def part1(input)
  paths = buildConnections(input.map { |i| i.split("-") } )
  return getAllRoutes(paths).length
end

def getAllRoutes2(paths)
  unfinishedRoutes = [["start"]]
  finishedRoutes = []
  loop do
    newUnfinished = []
    for i in unfinishedRoutes
      toAdd = getChildPaths2(i, paths)
      toAdd.each { |j| newUnfinished << j }
    end
    break if newUnfinished.length == 0
    unfinishedRoutes = newUnfinished.clone
    for i in unfinishedRoutes
      if i.slice(-1) == "end"
        finishedRoutes << i
      end
    end
  end
  return finishedRoutes
end

def hasDoubleSmall(path)
  for i in path
    if isSmall(i) and path.count(i) == 2
      return true
    end
  end
  return false
end

def getChildPaths2(currPath, paths)
  newPaths = []
  last = currPath.slice(-1)
  return [] if last == "end"
  for i in paths[last]
    if isSmall(i) and currPath.include? i
      next if i == "start"
      next if hasDoubleSmall(currPath)
    end
    newPaths.append(currPath.clone.append(i))
  end
  return newPaths
end

def part2(input)
  paths = buildConnections(input.map { |i| i.split("-") })
  #print paths
  #puts
  #getAllRoutes2(paths).each { |i|
  #  print i
  #  puts
  #}
  return getAllRoutes2(paths).length
end

#puts part1(sinput.clone) { |i| i }
#puts part1(input.clone) { |i| i }

puts

puts part2(sinput.clone)
puts part2(input.clone)