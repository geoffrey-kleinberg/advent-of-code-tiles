lines = []
file = 'input.txt'
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getPeople(lines)
  people = []
  for i in lines
    nextP = i.split(" ")[0]
    people << nextP if not people.include? nextP
  end
  return people
end

def getHappinesses(lines)
  happinesses = {}
  for i in lines
    words = i.split(" ")
    if not happinesses.keys.include? words[0]
      happinesses[words[0]] = {}
    end
    neighbor = words[-1].chop
    h = words[3].to_i
    if words[2] == 'lose'
      h *= -1
    end
    happinesses[words[0]][neighbor] = h
  end
  return happinesses
end

def getMaxHap(people, happinesses, numPeople, head)
  maxHap = Float::INFINITY * -1
  bestOrder = []
  people.permutation.each do |perm|
    happiness = 0
    happiness += happinesses[head][perm[0]]
    happiness += happinesses[head][perm[numPeople - 2]]
    happiness += happinesses[perm[0]][head]
    happiness += happinesses[perm[numPeople - 2]][head]
    for i in 0...(numPeople - 1)
      happiness += happinesses[perm[i]][perm[i - 1]] if i > 0
      happiness += happinesses[perm[i]][perm[i + 1]] if i < numPeople - 2
    end
    if happiness > maxHap
      maxHap = happiness
      bestOrder = perm
    end
  end
  return maxHap
end

def part1(lines)
  people = getPeople(lines)
  happinesses = getHappinesses(lines)

  numPeople = people.length
  head = people.delete_at(0)

  return getMaxHap(people, happinesses, numPeople, head)
end

def part2(lines)
  people = getPeople(lines)
  happinesses = getHappinesses(lines)

  happinesses["ME"] = {}
  for i in people
    happinesses["ME"][i] = 0
    happinesses[i]["ME"] = 0
  end
  people << "ME"

  numPeople = people.length
  head = people.delete_at(0)

  return getMaxHap(people, happinesses, numPeople, head)
end

puts part1(lines)
puts part2(lines)