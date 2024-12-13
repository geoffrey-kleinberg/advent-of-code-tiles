require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def moveRock(thisR, space, direction, bottom, left, width)
  data = []
  maxR = 6
  if direction == ">"
    data[1] = 1
    if left + width > maxR
      data[1] = 0
    else
      highest = [space.length - 1, bottom + thisR.length].min
      for i in bottom...(highest)
        for j in left...(left + width)
          next if thisR[i - bottom][j - left] == " "
          if space[i][j + 1] == "r"
            data[1] = 0
          end
        end
      end
    end
  else
    data[1] = -1
    if left <= 0
      data[1] = 0
    else
      highest = [space.length - 1, bottom + thisR.length].min
      for i in bottom...(highest)
        for j in left...(left + width)
          next if thisR[i - bottom][j - left] == " "
          if space[i][j - 1] == "r"
            data[1] = 0
          end
        end
      end
    end
  end
  left += data[1]
  data[0] = -1
  for i in 0...thisR.length
    for j in 0...thisR[i].length
      next if thisR[i][j] == " "
      next if not space[bottom + i - 1]
      if space[bottom + i - 1][j + left] == "r"
        data[0] = 0
      end
    end
  end
  return data
end

def part1(input)
  pattern = input[0].split("")
  space = [["r"] * 7]
  widths = {}
  rocks = [[["r", "r", "r", "r"]], [[" ", "r", " "], ["r", "r", "r"], [" ", "r", " "]],
          [["r", "r", "r"], [" ", " ", "r"], [" ", " ", "r"]],
          [["r"], ["r"], ["r"], ["r"]], [["r", "r"], ["r", "r"]]]
  rocks.each do |i|
    widths[i] = i.max { |a, b| a.length <=> b.length }.length
  end
  patternLoc = 0
  patternLength = pattern.length
  maxR = 6
  for rock in 0...2022
    thisR = rocks[rock % 5]
    startB = space.length + 3
    for i in space.length..startB
      if not space[i]
        space[i] = []
      end
    end
    startL = 2
    startR = startL + widths[thisR] - 1
    loop do
      direction = pattern.slice(patternLoc)
      move = moveRock(thisR.clone, space.clone, direction, startB, startL, widths[thisR])
      startB += move[0]
      startL += move[1]
      patternLoc += 1
      if patternLoc >= pattern.length
        patternLoc %= pattern.length
      end
      break if move[0] == 0
    end
    for i in startB...(startB + thisR.length)
      for j in startL...(startL + widths[thisR])
        if thisR[i - startB][j - startL] == "r"
          space[i][j] = "r"
        end
      end
    end
    space.delete_if { |i| i == [] }
  end
  return space.length - 1
end

def printSpace(space)
  space.reverse.each { |i| 
    puts (i.map { |k| k ? "#" : "." } + (["."] * (7 - i.length))).join
  }
end

def part2(input)
  pattern = input[0].split("")
  space = [["r"] * 7]
  widths = {}
  rocks = [[["r", "r", "r", "r"]], [[" ", "r", " "], ["r", "r", "r"], [" ", "r", " "]],
          [["r", "r", "r"], [" ", " ", "r"], [" ", " ", "r"]],
          [["r"], ["r"], ["r"], ["r"]], [["r", "r"], ["r", "r"]]]
  rocks.each do |i|
    widths[i] = i.max { |a, b| a.length <=> b.length }.length
  end
  patternLoc = 0
  patternLength = pattern.length
  maxR = 6
  rock = 0
  repeatLength = -1
  repeatTime = -1
  preH = -1
  repStart = -1
  #maps a pair to an ordered list of when they were seen
  pairSightings = {}
  #maps a pair to the list of rocks fallen in between
  betweenSightings = {}
  rockPlacements = []
  heights = []
  while true
    thisR = rocks[rock % 5]
    pair = [rock % 5, patternLoc]
    #if we haven't seen the pair before, remember it along with rock
    if not pairSightings[pair]
      pairSightings[pair] = [rock]
    #if we have seen it only once before, remember all rockPlacements from then till now
    #update most recent sighting rock
    elsif pairSightings[pair].length == 1
      #print pair
      #puts
      pairSightings[pair] << rock
      betweenSightings[pair] = [rockPlacements.last(pairSightings[pair][1] - pairSightings[pair][0])]
    elsif pairSightings[pair].length > 1
      pairSightings[pair] << rock
      prevPattern = rockPlacements.last(pairSightings[pair][1] - pairSightings[pair][0])
      if betweenSightings[pair].include? prevPattern
        #print pair
        #puts
        #print prevPattern
        #print pairSightings[pair]
        #puts
        prevFind = pairSightings[pair][betweenSightings[pair].rindex(prevPattern)]
        #puts prevFind
        other = pairSightings[pair].last(2)[0]
        #puts other
        bigNum = 1000000000000
        #bigNum = 2022
        repHeight = heights[other] - heights[prevFind]
        #puts repHeight
        startHeight = heights[prevFind]
        #puts startHeight
        fallsAfter = ((bigNum - prevFind) % (other - prevFind)) - 1
        #puts fallsAfter
        endHeight = heights[prevFind + fallsAfter] - heights[prevFind]
        #puts endHeight
        return startHeight + repHeight * ((bigNum - prevFind) / (other - prevFind)) + endHeight
        #puts ((bigNum - prevFind) / (other - prevFind))
        #puts "hallelujah"
        #puts
      end
      betweenSightings[pair] << prevPattern
    end
    #if we have seen the pair more than once
    #if the pattern from prev to now has appeared before, then there is some type of total pattern
    totalDown = 0
    startB = space.length + 3
    totalRight = 0
    for i in space.length..startB
      if not space[i]
        space[i] = []
      end
    end
    startL = 2
    loop do
      direction = pattern.slice(patternLoc)
      move = moveRock(thisR.clone, space.clone, direction, startB, startL, widths[thisR])
      startB += move[0]
      totalDown += move[0]
      startL += move[1]
      totalRight += move[1]
      patternLoc += 1
      if patternLoc >= pattern.length
        patternLoc %= pattern.length
      end
      break if move[0] == 0
    end
    for i in startB...(startB + thisR.length)
      for j in startL...(startL + widths[thisR])
        if thisR[i - startB][j - startL] == "r"
          space[i][j] = "r"
        end
      end
    end
    rockPlacements << ([totalDown, totalRight])
    space.delete_if { |i| i == [] }
    heights << space.length - 1
    rock += 1
  end
  #puts heights[1110]
  #puts heights[4580] - heights[2845]
  #puts heights[2845] - heights[1110]
  #puts (1000000000000 - 1110) % (2845 - 1110)
  #       preH = bases[[rock % 5, patternLoc]][0] - 1
  #       repStart = bases[[rock % 5, patternLoc]][1]
  #postH = part1([input[0].split("").rotate(patternLoc).join], (1000000000000 - repStart) % repeatTime)
  return 0
end

puts part1(data)
puts part2(data)