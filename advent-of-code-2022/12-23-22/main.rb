require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def printElves(elfLocs)
  minR = elfLocs.keys.min { |i, j| i[0] <=> j[0] }[0]
  minC = elfLocs.keys.min { |i, j| i[1] <=> j[1] }[1]
  maxR = elfLocs.keys.max { |i, j| i[0] <=> j[0] }[0]
  maxC = elfLocs.keys.max { |i, j| i[1] <=> j[1] }[1]
  strs = []
  for i in minR..maxR
    strs << ""
  end
  for i in 0..(maxR - minR)
    for j in minC..maxC
      if elfLocs[[i + minR, j]]
        strs[i] += "#"
      else
        strs[i] += "."
      end
    end
  end
  strs.each { |i| puts i }
end

def getNCheck(loc)
  n = [loc[0] - 1, loc[1]]
  nw = [loc[0] - 1, loc[1] - 1]
  ne = [loc[0] - 1, loc[1] + 1]
  return [n, nw, ne]
end

def getSCheck(loc)
  s = [loc[0] + 1, loc[1]]
  sw = [loc[0] + 1, loc[1] - 1]
  se = [loc[0] + 1, loc[1] + 1]
  return [s, sw, se]
end

def getWCheck(loc)
  w = [loc[0], loc[1] - 1]
  nw = [loc[0] - 1, loc[1] - 1]
  sw = [loc[0] + 1, loc[1] - 1]
  return [w, nw, sw]
end

def getECheck(loc)
  e = [loc[0], loc[1] + 1]
  ne = [loc[0] - 1, loc[1] + 1]
  se = [loc[0] + 1, loc[1] + 1]
  return [e, ne, se]
end

def getAll(loc)
  allN = []
  for i in -1..1
    for j in -1..1
      next if i == 0 and j == 0
      allN << [loc[0] + i, loc[1] + j]
    end
  end
  return allN
end

def part1(input)
  checkOrder = ["N", "S", "W", "E"]
  elfLocs = {}
  for i in 0...input.length
    for j in 0...input[i].length
      if input[i].slice(j) == "#"
        elfLocs[[i, j]] = true
      end
    end
  end
  round = 0
  while round < 10
    nextLocs = {}
    for i in elfLocs.keys
      next if not elfLocs[i]
      nextLocs[i] = i.clone
    end
    thisOrder = checkOrder.rotate(round % 4)
    move = ""
    notAllowed = Set[]
    for elf in elfLocs.keys
      next if not elfLocs[i]
      spaces = [getNCheck(elf), getSCheck(elf), getWCheck(elf), getECheck(elf)]
      spaces = spaces.rotate(round % 4)
      spaces.prepend(getAll(elf))
      success = false
      for check in 0...5
        neighbors = spaces[check]
        filled = neighbors.map { |i| elfLocs[i] }
        if filled.compact.length == 0
          if check == 0
            move = "none"
          else
            move = thisOrder[check - 1]
          end
          success = true
          break
        end
      end
      if not success
        move = "none"
      end
      if move == "N"
        proposed = [elf[0] - 1, elf[1]]
      elsif move == "S"
        proposed = [elf[0] + 1, elf[1]]
      elsif move == "W"
        proposed = [elf[0], elf[1] - 1]
      elsif move == "E"
        proposed = [elf[0], elf[1] + 1]
      elsif move == "none"
        proposed = elf.clone
      else
        raise 'balls'
      end
      nextLocs[elf] = proposed
      # if round == 2
      #   print elf
      #   puts
      #   print proposed
      #   puts
      #   puts nextLocs
      #   puts
      # end
      if not notAllowed.add? (proposed)
        for i in nextLocs.keys
          if nextLocs[i] == proposed
            nextLocs[i.clone] = i.clone
          end
        end
      end
    end
    # print nextLocs
  #   puts
    elfLocs = {}
    if nextLocs.values.uniq != nextLocs.values
      raise 'af'
    end
    for i in nextLocs.values  
      elfLocs[i] = true
    end
    round += 1
    puts round
    # print elfLocs
    # puts
    # puts
    # puts
  end
  minR = elfLocs.keys.min { |i, j| i[0] <=> j[0] }[0]
  #puts minR
  minC = elfLocs.keys.min { |i, j| i[1] <=> j[1] }[1]
  #puts minC
  maxR = elfLocs.keys.max { |i, j| i[0] <=> j[0] }[0]
  #puts maxR
  maxC = elfLocs.keys.max { |i, j| i[1] <=> j[1] }[1]
  #puts maxC
  return (maxR - minR + 1) * (maxC - minC + 1) - elfLocs.size
end

def part2(input)
  checkOrder = ["N", "S", "W", "E"]
  elfLocs = {}
  for i in 0...input.length
    for j in 0...input[i].length
      if input[i].slice(j) == "#"
        elfLocs[[i, j]] = true
      end
    end
  end
  round = 0
  while true
    nextLocs = {}
    for i in elfLocs.keys
      next if not elfLocs[i]
      nextLocs[i] = i.clone
    end
    thisOrder = checkOrder.rotate(round % 4)
    move = ""
    notAllowed = Set[]
    for elf in elfLocs.keys
      next if not elfLocs[i]
      spaces = [getNCheck(elf), getSCheck(elf), getWCheck(elf), getECheck(elf)]
      spaces = spaces.rotate(round % 4)
      spaces.prepend(getAll(elf))
      success = false
      for check in 0...5
        neighbors = spaces[check]
        filled = neighbors.map { |i| elfLocs[i] }
        if filled.compact.length == 0
          if check == 0
            move = "none"
          else
            move = thisOrder[check - 1]
          end
          success = true
          break
        end
      end
      if not success
        move = "none"
      end
      if move == "N"
        proposed = [elf[0] - 1, elf[1]]
      elsif move == "S"
        proposed = [elf[0] + 1, elf[1]]
      elsif move == "W"
        proposed = [elf[0], elf[1] - 1]
      elsif move == "E"
        proposed = [elf[0], elf[1] + 1]
      elsif move == "none"
        proposed = elf.clone
      else
        raise 'balls'
      end
      nextLocs[elf] = proposed
      # if round == 2
      #   print elf
      #   puts
      #   print proposed
      #   puts
      #   puts nextLocs
      #   puts
      # end
      if not notAllowed.add? (proposed)
        for i in nextLocs.keys
          if nextLocs[i] == proposed
            nextLocs[i.clone] = i.clone
          end
        end
      end
    end
    if not nextLocs.any? { |k, v| k != v }
      puts "NO CHANGE"
      return round + 1
    end
    # print nextLocs
  #   puts

    elfLocs = {}
    if nextLocs.values.uniq != nextLocs.values
      raise 'af'
    end
    for i in nextLocs.values  
      elfLocs[i] = true
    end
    round += 1
    puts round
    #printElves(elfLocs.clone)
    #break if round == 20
    # print elfLocs
    # puts
    # puts
    # puts
  end
  return round
end

#puts part1(data)
puts part2(data)