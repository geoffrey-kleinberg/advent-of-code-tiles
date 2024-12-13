require 'set'

day = "10"
file_name = "12-#{day}-16/sampleIn.txt"
# file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def followsRules(floor)
  chips = []
  rtgs = Set[]
  for item in floor
    if item.slice(-1) == "M"
      chips.append(item.slice(0))
    end
    if item.slice(-1) == "G"
      rtgs.add(item.slice(0))
    end
  end
  if rtgs.size == 0
    return true
  end
  for c in chips
    if not rtgs.include? c
      return false
    end
  end
  return true
end

def getAllPossibleNext(state)
  possibleNext = []
  nextFloors = []
  if state[4] != 0
    nextFloors.append(state[4] - 1)
  end
  if state[4] != 3
    nextFloors.append(state[4] + 1)
  end
  thisFloor = state[state[4]]
  canTake = []
  for i in 0...thisFloor.length
    canTake.append([thisFloor[i]])
    for j in (i + 1)...thisFloor.length
      canTake.append([thisFloor[i], thisFloor[j]])
    end
  end
  for floor in nextFloors
    for things in canTake
      fromFloor = []
      for i in state[state[4]]
        if not (i == things[0] or i == things[1])
          fromFloor.append(i)
        end
      end
      toFloor = state[floor] + things

      if followsRules(fromFloor) and followsRules(toFloor)
        newState = state.clone
        for i in 0...4
          if i == state[4]
            newState[i] = fromFloor.sort
          elsif i == floor
            newState[i] = toFloor.sort
          else
            newState[i] = newState[i].clone
          end
        end
        newState[4] = floor
        newState[5] += 1
        possibleNext.append(newState)
      end
    end
  end

  return possibleNext
end

def getState(state)
  pairLocs = {}
  for i in 0...4
    for j in state[i]
      element = j.slice(0)
      type = j.slice(1)
      if not pairLocs[element]
        pairLocs[element] = []
      end
      if type == 'G'
        pairLocs[element][0] = i
      end
      if type == 'M'
        pairLocs[element][1] = i
      end
    end
  end
  pairLocsSet = Set.new(pairLocs.values)

  return [pairLocsSet, state[4]]
end

def part1old(input)
    start = [
        ['TG', 'TM', 'PG', 'SG'],
        ['PM', 'SM'],
        ['OG', 'OM', 'RG', 'RM'],
        [],
        0,
        0
    ]
    # first floor, second floor, third floor, fourth floor, elevator location, dist
    # start = [
    #     ['HM', 'LM'],
    #     ['HG'],
    #     ['LG'],
    #     [],
    #     0,
    #     0
    # ]

    queue = [start]

    longest = 0

    visited = Set[]

    maxIter = 2
    iter = 0

    while queue.length > 0
      cur = queue.shift
      visited.add(getState(cur))
      if [cur[0], cur[1], cur[2]].all? { |i| i.length == 0 }
        return cur[5]
      end

      if cur[5] > longest
        puts queue.length
        longest += 1
      end

    #   iter += 1
    #   if iter > maxIter
    #     return nil
    #   end

      allNext = getAllPossibleNext(cur)

      for i in allNext
        if not visited.include? getState(i)
          queue.append(i)
        end
      end

    #   print queue
    #   puts
    end
end

def part1(input)
  perFloor = [4, 2, 4, 0]
  moves = 0
  low = 0
  while low != 3
    while perFloor[low] == 0
      low += 1
    end
    break if low >= 3
    moves += 2 * (perFloor[low] - 1) - 1
    perFloor[low + 1] += perFloor[low]
    perFloor[low] = 0
  end
  return moves
end

def part2(input)
  perFloor = [8, 2, 4, 0]
  moves = 0
  low = 0
  while low != 3
    while perFloor[low] == 0
      low += 1
    end
    break if low >= 3
    moves += 2 * (perFloor[low] - 1) - 1
    perFloor[low + 1] += perFloor[low]
    perFloor[low] = 0
  end
  return moves
end

puts part1(data)
puts part2(data)
