file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getStartMolecule(lines)
  return lines.slice(-1).strip
end

def getReplacementMap(lines)
  replacements = lines.slice(0, lines.length - 2).map { |i| i.strip }
  replacementMap = {}
  replacements.each do |i|
    elements = i.split(" => ")
    if not replacementMap.keys.include? elements[0]
      replacementMap[elements[0]] = []
    end
    replacementMap[elements[0]] << elements[1]
  end
  return replacementMap
end

def getPossibleReplacements(startMolecule, replacementMap)
  possibleReplacements = []
  for i in replacementMap.keys
    len = i.length
    for j in 0..(startMolecule.length - len)
      if startMolecule.slice(j, len) == i
        for r in replacementMap[i]
          newMolecule = ""
          newMolecule += startMolecule.slice(0, j)
          newMolecule += r
          newMolecule += startMolecule.slice(j + len, startMolecule.length - (j + len))
          possibleReplacements << newMolecule
        end
      end
    end
  end
  return possibleReplacements
end

def part1(lines)
  startMolecule = getStartMolecule(lines)
  replacementMap = getReplacementMap(lines)
  possibleReplacements = getPossibleReplacements(startMolecule, replacementMap)
  return possibleReplacements.uniq.length
end

def getReverseMap(rMap)
  newMap = {}
  for i in rMap.keys
    for j in rMap[i]
      newMap[j] = [i]
    end
  end
  return newMap   
end

def recurse(startMolecule, startRep, reverseMap)
  replacements = {
    startMolecule => startRep
  }
  queue = [startMolecule]
  loop do
    current = queue[0]
    possibleReplacements = getPossibleReplacements(queue[0], reverseMap)
    for i in possibleReplacements
      if replacements[i]
        replacements[i] = [replacements[i], replacements[queue[0]] + 1].min
      else
        replacements[i] = replacements[queue[0]] + 1
      end
      for j in 0...(queue.length)
        if queue[j].length > i.length
          queue.insert(j, i)
          break
        end
      end
    end
    queue.delete(current)
    break if queue.length == 0
  end
  return replacements.select { |k, v| not k.include? "Ar" }
end

def part2(lines)
  startMolecule = getStartMolecule(lines)
  replacementMap = getReplacementMap(lines)
  reverseMap = getReverseMap(replacementMap)
  replacements = 0
  while startMolecule != 'e'
    # repLocations = {}
    # for m in reverseMap.keys
    #   if startMolecule.include? m
    #     repLocations[m] = startMolecule.index(m)
    #   end
    # end
    
          
    i = startMolecule.length - 1
    while i >= 0
      for mol in reverseMap.keys
        if mol == startMolecule.slice(i, mol.length) and not reverseMap[mol].include? 'e'
          replace = true
          replacements += 1

          startMolecule = startMolecule.slice(0, i) + reverseMap[mol][0] + startMolecule.slice(i + mol.length, startMolecule.length - (i + mol.length))
          break
        elsif reverseMap[mol].include? 'e' and mol == startMolecule
          return replacements + 1
        end
      end
      i -= 1
    end
  end
  return replacements
end

# def getNextRMap(rMaps, known)
#   toGen = known.max + 1
#   lastGen = rMaps[toGen - 1]
#   oneRep = rMaps[1]
#   nextMap = {}
#   nextMap["e"] = []
#   for j in lastGen["e"]
#     for k in getPossibleReplacements(j, oneRep)
#       nextMap["e"] << k if not nextMap["e"].include? k
#     end
#   end
#   return nextMap
# end

def splitOnAr(molecule)
  arr = []
  start = 0
  for i in 0...(molecule.length - 1)
    if molecule.slice(i, 2) == "Ar"
      arr << molecule.slice(start, i - start + 2)
      start = i + 2
    end
  end
  arr << molecule.slice(start, molecule.length - start)
  return arr
end

# def part2b(lines)
#    goalMolecule = getStartMolecule(lines)
#    startRMap = getReplacementMap(lines)
#
#   replacementMaps = [nil, startRMap]
#   known = [1]
#
#   while true
#     replacementMaps << getNextRMap(replacementMaps, known)
#     if replacementMaps[known.max]["e"].include? goalMolecule
#       return known.max
#     end
#     puts known.max
#     known << (known.max + 1)
#   end
#   units = splitOnAr(goalMolecule)
#   print units
#   puts
#   return 0
#
# end

#puts part1(lines)
puts part2(lines)