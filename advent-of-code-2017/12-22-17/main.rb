require 'set'

day = "22"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def move(loc, dir)
  return [loc[0] + dir[0], loc[1] + dir[1]]
end

def turnLeft(dir)
  if dir == [1, 0]
    return [0, 1]
  end
  if dir == [0, 1]
    return [-1, 0]
  end
  if dir == [-1, 0]
    return [0, -1]
  end
  if dir == [0, -1]
    return [1, 0]
  end
end

def turnRight(dir)
  if dir == [1, 0]
    return [0, -1]
  end
  if dir == [0, -1]
    return [-1, 0]
  end
  if dir == [-1, 0]
    return [0, 1]
  end
  if dir == [0, 1]
    return [1, 0]
  end
end

def part1(input)
    bursts = 10000

    infected = {}

    # we are using x, y not i, j
    
    virusLoc = [0, 0]
    virusDir = [0, 1]

    startGrid = input.map { |i| i.split("") }
    center = startGrid.length / 2

    d = [-1 * center, -1 * center]

    for i in 0...startGrid.length
      for j in 0...startGrid.length
        if startGrid[i][j] == "#"
          infected[move([j, startGrid.length - i - 1], d)] = true
        end
      end
    end

    count = 0

    bursts.times do
      if infected[virusLoc]
        virusDir = turnRight(virusDir)
      else
        virusDir = turnLeft(virusDir)
      end

      if not infected[virusLoc]
        infected[virusLoc] = true
        count += 1
      else
        infected[virusLoc] = false
      end

      virusLoc = move(virusLoc, virusDir)

    #   print infected
    #   puts
    end
    
    return count
end

def part2(input)
    bursts = 10000000

    weakened = Set[]
    infected = Set[]
    flagged = Set[]

    # we are using x, y not i, j
    
    virusLoc = [0, 0]
    virusDir = [0, 1]

    startGrid = input.map { |i| i.split("") }
    center = startGrid.length / 2

    d = [-1 * center, -1 * center]

    for i in 0...startGrid.length
      for j in 0...startGrid.length
        if startGrid[i][j] == "#"
          infected.add(move([j, startGrid.length - i - 1], d))
        end
      end
    end


    count = 0

    bursts.times do
      if infected.include? virusLoc
        virusDir = turnRight(virusDir)
      elsif flagged.include? virusLoc
        virusDir = [-1 * virusDir[0], -1 * virusDir[1]]
      elsif weakened.include? virusLoc
      else
        virusDir = turnLeft(virusDir)
      end

      if infected.include? virusLoc
        infected.delete(virusLoc)
        flagged.add(virusLoc)
      elsif weakened.include? virusLoc
        weakened.delete(virusLoc)
        infected.add(virusLoc)
        count += 1
      elsif flagged.include? virusLoc
        flagged.delete(virusLoc)
      else
        weakened.add(virusLoc)
      end

      virusLoc = move(virusLoc, virusDir)

    #   print infected
    #   puts
    end
    
    return count
end

# puts part1(data)
puts part2(data)