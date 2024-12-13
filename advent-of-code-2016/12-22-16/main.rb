require 'set'

day = "22"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  nodes = {}

  for line in input
    parts = line.split(" ")
    x, y = parts[0].split("-")[1...].map { |i| i[1..].to_i }
    size, used, avail = parts[1..3].map { |i| i[0...-1].to_i }

    nodes[[x, y]] = [size, used, avail]

  end

  viablePairs = []

  nodeLocs = nodes.keys
  count = 0

  for i in 0...nodeLocs.length
    for j in 0...nodeLocs.length
      next if i == j
      a = nodeLocs[i]
      b = nodeLocs[j]
      next if nodes[a][1] == 0
      next if nodes[a][1] > nodes[b][2]
      viablePairs.append([i, j])
      count += 1
    end
  end

  print viablePairs.filter { |i| not i.include? 888 }

  puts

  return count
end

def getAllPossibleNext(state)
  possible = []
  grid, goalLoc, dist = state

  for loc in grid.keys
    next if grid[loc][1] == 0
    for dir in [[1, 0], [0, 1], [-1, 0], [0, -1]]
      toLoc = [loc[0] + dir[0], loc[1] + dir[1]]
      next if toLoc[0] < 0 or toLoc[1] < 0 or toLoc[0] > 31 or toLoc[1] > 30
      # next if toLoc[0] < 0 or toLoc[1] < 0 or toLoc[0] > 2 or toLoc[1] > 2
      next if grid[loc][1] > grid[toLoc][2]
      newState = {}
      for l in grid.keys
        newState[l] = grid[l].clone
      end
      newState[toLoc][1] += newState[loc][1]
      newState[toLoc][2] -= newState[toLoc][1]
      newState[loc][1] = 0
      newState[loc][2] = newState[loc][0]

      if loc == goalLoc
        possible.append([newState, toLoc, dist + 1])
      else
        possible.append([newState, goalLoc, dist + 1])
      end
    end
  end
  return possible
end


def part2(input)

  # this is the "general" solution
  # it will work (hopefully) but it will take forever
  # nodes = {}

  # for line in input
  #   parts = line.split(" ")
  #   x, y = parts[0].split("-")[1...].map { |i| i[1..].to_i }
  #   size, used, avail = parts[1..3].map { |i| i[0...-1].to_i }

  #   nodes[[x, y]] = [size, used, avail]

  # end

  # startNode = [31, 0]
  # # startNode = [2, 0]

  # startDist = 31
  # # startDist = 2

  # seen = Set[]
  # queue = {
  #   startDist => [[nodes, startNode, 0]]
  # }

  # while queue.length > 0
  #   fastest = queue.keys.min
  #   cur = queue[fastest].shift
  #   if queue[fastest].length == 0
  #     queue.delete(fastest)
  #   end
  #   seen.add(cur)

  #   if cur[1] == [0, 0]
  #     return cur[2]
  #   end

  #   nextStates = getAllPossibleNext(cur)
  #   for s in nextStates
  #     next if seen.include? s
  #     heuristic = s[1].sum + s[2]
  #     if not queue[heuristic]
  #       queue[heuristic] = []
  #     end
  #     queue[heuristic].append(s)
  #   end
  # end


  # from part 1, we see that there are no viable pairs except for ones including the empty node
  # also, all the nodes that can fit into the open node can fit within the capacity of any other node
  # so, there will only ever be one opening 
  # also, some nodes are immovable
  
  opening = nil
  movable = Set[]

  nodes = {}

  for line in input
    parts = line.split(" ")
    x, y = parts[0].split("-")[1...].map { |i| i[1..].to_i }
    size, used, avail = parts[1..3].map { |i| i[0...-1].to_i }

    nodes[[x, y]] = [size, used, avail]

  end

  nodeLocs = nodes.keys

  for i in 0...nodeLocs.length
    for j in 0...nodeLocs.length
      next if i == j
      a = nodeLocs[i]
      b = nodeLocs[j]
      next if nodes[a][1] == 0
      next if nodes[a][1] > nodes[b][2]
      movable.add(a)
      opening = b
    end
  end

  immovable = nodes.keys.to_set - movable
  immovable.delete(opening)

  puts "processed"

  if true
    for j in 0..30
      for i in 0..31
        if opening == [i, j]
          print "-"
        elsif immovable.include? [i, j]
          print "#"
        elsif [i, j] == [31, 0]
          print "G"
        else
          print "."
        end
      end
      puts
    end
  end

  if false
    seenStates = Set[]

    start = [opening, [31, 0]]

    queue = {
      31 => [[start, 0]]
    }

    # print queue
    # puts
    maxDist = 0

    while queue.size > 0
      smallest = queue.keys.min
      cur = queue[smallest].shift
      if queue[smallest].length == 0
        queue.delete(smallest)
      end

      state = cur[0]
      seenStates.add(state)
      dist = cur[1]
      if dist > maxDist
        puts maxDist
        maxDist = dist
      end
      opening = state[0]
      goalLoc = state[1]
      if goalLoc == [0, 0]
        return dist
      end

      for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
        nextOpening = [opening[0] + dir[0], opening[1] + dir[1]]
        next if immovable.include? nextOpening
        next if nextOpening[0] < 0 or nextOpening[1] < 0 or nextOpening[0] > 31 or nextOpening[1] > 30
        # next if nextOpening[0] < 0 or nextOpening[1] < 0 or nextOpening[0] > 2 or nextOpening[1] > 2

        nextGoal = goalLoc
        if nextOpening == goalLoc
          nextGoal = opening
        end


        nextState = [nextOpening, nextGoal]

        next if seenStates.include? nextState

        heuristic = nextGoal.sum + dist + 1
        if not queue[heuristic]
          queue[heuristic] = []
        end
        queue[heuristic].append([nextState, dist + 1])
      end
      # print queue
      # puts
    end
  end

  ## MANUAL SOLUTION
  moves = 0
  moves += 3
  moves += 20
  moves += 6

  # G is at (30, 0), hole at (31, 0)
  moves += 5

  # G is at (29, 0), hole at (30, 0)
  moves += 5 * 28

  # G is at (1, 0), hole at (2, 0)
  moves += 5
  return moves
end

# puts part1(data)
# 1860 too high
puts part2(data)