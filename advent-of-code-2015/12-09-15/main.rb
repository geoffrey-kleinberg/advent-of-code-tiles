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

def part1(input)
  allDestinations = Set[]
  distances = {}
  for i in input
    cities = i.split(" = ")[0].split(" to ")
    distance = i.split(" = ")[1].to_i
    allDestinations.add(cities[0])
    allDestinations.add(cities[1])
    distances[Set[cities[0], cities[1]]] = distance
  end
  minDistance = Float::INFINITY
  for i in allDestinations.to_a.permutation
    distance = 0
    for j in 0...(i.length - 1)
      distance += distances[Set[i[j], i[j + 1]]]
    end
    minDistance = [distance, minDistance].min
  end
  return minDistance
end

def part2(input)
  allDestinations = Set[]
  distances = {}
  for i in input
    cities = i.split(" = ")[0].split(" to ")
    distance = i.split(" = ")[1].to_i
    allDestinations.add(cities[0])
    allDestinations.add(cities[1])
    distances[Set[cities[0], cities[1]]] = distance
  end
  maxDistance = Float::INFINITY * -1
  for i in allDestinations.to_a.permutation
    distance = 0
    for j in 0...(i.length - 1)
      distance += distances[Set[i[j], i[j + 1]]]
    end
    maxDistance = [distance, maxDistance].max
  end
  return maxDistance
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)