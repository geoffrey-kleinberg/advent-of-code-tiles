require 'set'

day = "06"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    grid = input.map { |i| i.split("") }
    guardI = nil
    guardJ = nil
    visited = Set.new()
    for i in 0...grid.length
      if grid[i].include? "^"
        guardI = i
        guardJ = grid[i].index("^")
        grid[guardI][guardJ] = "."
        break
      end
    end

    dir = [-1, 0]
    
    while true
        visited.add([guardI, guardJ])
        nextI = guardI + dir[0]
        nextJ = guardJ + dir[1]
        if nextI >= grid.length or nextI < 0 or nextJ >= grid[nextI].length or nextJ < 0
          break
        end
        if grid[nextI][nextJ] == "#"
          if dir == [-1, 0]
            dir = [0, 1]
          elsif dir == [0, 1]
            dir = [1, 0]
          elsif dir == [1, 0]
            dir = [0, -1]
          elsif dir == [0, -1]
            dir = [-1, 0]
          end
        else
          guardI = nextI
          guardJ = nextJ
        end
    end

    return visited.size
end

def part2(input)
    grid = input.map { |i| i.split("") }
    startI = nil
    startJ = nil
    for i in 0...grid.length
      if grid[i].include? "^"
        startI = i
        startJ = grid[i].index("^")
        grid[startI][startJ] = "."
        break
      end
    end

    count = 0

    for obsI in 0...grid.length
      puts obsI
      for obsJ in 0...grid[i].length
        next if grid[obsI][obsJ] != "."
        guardI = startI
        guardJ = startJ
        grid[obsI][obsJ] = "#"
        dir = 0
        visited = Set.new()

        while true
            visited.add([guardI, guardJ, dir])
            nextI = guardI + (1 - (dir % 2)) * (dir - 1)
            nextJ = guardJ + (dir % 2) * (2 - dir)
            if visited.include? [nextI, nextJ, dir]
              count += 1
              break
            end
            if nextI >= grid.length or nextI < 0 or nextJ >= grid[nextI].length or nextJ < 0
              break
            end
            if grid[nextI][nextJ] == "#"
              dir = (dir + 1) % 4
            else
              guardI = nextI
              guardJ = nextJ
            end
        end
        grid[obsI][obsJ] = "."
      end
    end

    return count
end

# puts part1(data)
puts part2(data)