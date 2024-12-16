require 'set'

day = "19"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i }

def getGrid(grid, coord)
  i = coord[0]
  j = coord[1]
  if i < 0 or j < 0 or i >= grid.length or j >= grid[i].length
    return " "
  end
  return grid[i][j]
end

def part1(input)
    grid = input.map { |i| i.split("") }
    loc = nil
    dir = [1, 0]

    for j in 0...grid[0].length
      if grid[0][j] == "|"
        loc = [0, j]
      end
    end

    letters = ""

    while true
      nextLoc = [loc[0] + dir[0], loc[1] + dir[1]]
      nextSym = getGrid(grid, nextLoc)
      if nextSym == "+"
        if dir[1] == 0
          if getGrid(grid, [nextLoc[0], nextLoc[1] - 1]) == " "
            dir = [0, 1]
          elsif getGrid(grid, [nextLoc[0], nextLoc[1] + 1]) == " "
            dir = [0, -1]
          else
            raise 'nowhere to go'
          end
        elsif dir[0] == 0
          if getGrid(grid, [nextLoc[0] - 1, nextLoc[1]]) == " "
            dir = [1, 0]
          elsif getGrid(grid, [nextLoc[0] + 1, nextLoc[1]]) == " "
            dir = [-1, 0]
          else
            raise 'nowhere to go'
          end
        end
      elsif nextSym == "|" or nextSym == "-"
      elsif nextSym == " "
        return letters
      else
        letters += nextSym
      end

      loc = nextLoc

    end
end

def part2(input)
    grid = input.map { |i| i.split("") }
    loc = nil
    dir = [1, 0]

    for j in 0...grid[0].length
      if grid[0][j] == "|"
        loc = [0, j]
      end
    end

    steps = 0

    while true
      nextLoc = [loc[0] + dir[0], loc[1] + dir[1]]
      nextSym = getGrid(grid, nextLoc)
      if nextSym == "+"
        if dir[1] == 0
          if getGrid(grid, [nextLoc[0], nextLoc[1] - 1]) == " "
            dir = [0, 1]
          elsif getGrid(grid, [nextLoc[0], nextLoc[1] + 1]) == " "
            dir = [0, -1]
          else
            raise 'nowhere to go'
          end
        elsif dir[0] == 0
          if getGrid(grid, [nextLoc[0] - 1, nextLoc[1]]) == " "
            dir = [1, 0]
          elsif getGrid(grid, [nextLoc[0] + 1, nextLoc[1]]) == " "
            dir = [-1, 0]
          else
            raise 'nowhere to go'
          end
        end
      elsif nextSym == "|" or nextSym == "-"
      elsif nextSym == " "
        return steps + 1
      end

      loc = nextLoc
      steps += 1

    end
end


puts part1(data)
puts part2(data)