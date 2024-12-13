require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def neighbor(l1, l2)
  dist = []
  for i in 0...3
    dist[i] = (l1[i] - l2[i]).abs
  end
  return (dist.count(1) == 1 and dist.count(0) == 2)
end

def part1(input)
  locations = input.map { |i| i.split(",").map { |j| j.to_i }}
  total = locations.length * 6
  for i in 0...locations.length
    for j in 0...locations.length
      if neighbor(locations[i], locations[j])
        total -= 1
      end
    end
  end
  return total
end

def manDist(l1, l2)
  dists = []
  for i in 0...3
    dists[i] = (l1[i] - l2[i]).abs
  end
  return dists.sum
end

def getAdj(l1)
  adj = []
  for i in -1..1
    for j in -1..1
      for k in -1..1
        next if [i, j, k].count(0) != 2
        adj << [l1[0] + i, l1[1] + j, l1[2] + k]
      end
    end
  end
  return adj
end

def getClosestDist(l1, locations)
  if locations.include? l1
    return 0
  end
  checked = Set[]
  dists = { 0 => [l1] }
  while true
    closestDist = dists.keys.min
    curr = dists[closestDist][0]
    if locations.include? curr
      return closestDist
    end
    neighbors = getAdj(curr)
    for i in neighbors
      next if checked.include? i
      if locations.include? i
        return closestDist + 1
      end
      if not dists[closestDist + 1]
        dists[closestDist + 1] = []
      end
      dists[closestDist + 1].append(i)
    end
    dists[closestDist].delete_at(0)
    if dists[closestDist].length == 0
      dists.delete(closestDist)
    end
  end
end

def part2(input)
  locations = input.map { |i| i.split(",").map { |j| j.to_i }}.to_set
  minX = locations.min { |i, j| i[0] <=> j[0] }[0] - 1
  minY = locations.min { |i, j| i[1] <=> j[1] }[1] - 1
  minZ = locations.min { |i, j| i[2] <=> j[2] }[2] - 1
  minPossible = [minX, minY, minZ]
  closest = locations.min { |i, j| manDist(i, minPossible) <=> manDist(j, minPossible)}
  seed = closest.clone
  seed[0] -= 1
  #seed = [2, 6, 3]
  #seed = [0, 2, 2]
  checked = Set[]
  queue = [seed]
  border = Set[seed]
  close = {}
  duhh = 0
  while queue.length > 0
    curr = queue[0]
    checked.add(curr)
    for adj in getAdj(curr)
      next if checked.include? adj
      next if border.include? adj
      next if locations.include? adj
      a = getClosestDist(adj, locations)
      if a == 0
        next
      elsif a == 1
        border.add(adj)
        queue.append(adj)
      elsif a == 2
        queue.append(adj)
      end
    end
    queue.delete_at(0)
  end
  puts "border found"
  puts duhh
  #puts border
  puts border.size
  total = 0
  for i in border
    for j in locations
      if manDist(i, j) == 1
        total += 1
      end
    end
  end
  return total
end

t = Time.now
puts part1(data)
puts Time.now - t

t = Time.now
puts part2(data)
puts Time.now - t