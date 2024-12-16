require 'set'

day = "15"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    grid = []
    moves = []
    doingGrid = true
    for line in input
      if line == ""
        doingGrid = false
        next
      end
      if doingGrid
        grid.append(line.split(""))
      else
        moves += line.split("")
      end
    end

    robotLoc = nil
    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "@"
          robotLoc = [i, j]
          grid[i][j] = "."
        end
      end
    end

    for m in moves
      dir = nil
      if m == "^"
        dir = [-1, 0]
      elsif m == "v"
        dir = [1, 0]
      elsif m == ">"
        dir = [0, 1]
      elsif m == "<"
        dir = [0, -1]
      end

      movedBox = false

      nextLoc = [robotLoc[0] + dir[0], robotLoc[1] + dir[1]]
      nextObj = grid[nextLoc[0]][nextLoc[1]]

      while nextObj == "O"
        movedBox = true
        nextLoc = [nextLoc[0] + dir[0], nextLoc[1] + dir[1]]
        nextObj = grid[nextLoc[0]][nextLoc[1]]
      end
      if nextObj == "."
        robotLoc = [robotLoc[0] + dir[0], robotLoc[1] + dir[1]]
        grid[robotLoc[0]][robotLoc[1]] = "." if movedBox
        grid[nextLoc[0]][nextLoc[1]] = "O" if movedBox
        next
      end

      if nextObj == "#"
        next
      end

    end

    gps = 0

    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "O"
          gps += 100 * i + j
        end
      end
    end

    return gps
end

def displayGrid(grid, rLoc)
  for i in 0...grid.length
    for j in 0...grid[i].length
      if [i, j] == rLoc
        print "@"
      else
        print grid[i][j]
      end
    end
    puts
  end
end


# 1484187 too low

def part2(input)
    grid = []
    moves = []
    doingGrid = true
    for line in input
      if line == ""
        doingGrid = false
        next
      end
      if doingGrid
        grid.append(line.split(""))
      else
        moves += line.split("")
      end
    end

    for i in 0...grid.length
      grid[i] = grid[i].map do |j| 
        if j == "."
          ".."
        elsif j == "#"
          "##"
        elsif j == "O"
          "[]"
        elsif j == "@"
          "@."
        end
      end.join.split("")
    end

    robotLoc = nil
    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "@"
          robotLoc = [i, j]
          grid[i][j] = "."
        end
      end
    end

    # displayGrid(grid, robotLoc)
    # puts

    for m in moves
    #   _ = gets
      dir = nil
      if m == "^"
        dir = [-1, 0]
      elsif m == "v"
        dir = [1, 0]
      elsif m == ">"
        dir = [0, 1]
      elsif m == "<"
        dir = [0, -1]
      end

    #   print robotLoc
    #   puts 
    #   puts m

      movedBox = false

      nextLoc = [robotLoc[0] + dir[0], robotLoc[1] + dir[1]]
      nextObj = grid[nextLoc[0]][nextLoc[1]]

      nextLocs = [nextLoc]
      nextObjs = [nextObj]
      if nextObj == "[" and dir[1] == 0
        nextLocs.append([nextLoc[0], nextLoc[1] + 1])
        nextObjs.append("]")
      end
      if nextObj == "]" and dir[1] == 0
        nextLocs.append([nextLoc[0], nextLoc[1] - 1])
        nextObjs.append("[")
      end

    #   if iter == 0
    #     print nextLocs
    #     puts
    #     print nextObjs
    #     puts
    #   end

      allLocs = nextLocs

      while nextObjs.include? "[" or nextObjs.include? "]"
        movedBox = true
        locs = []
        for lidx in 0...nextLocs.length
          l = nextLocs[lidx]
          next if grid[l[0]][l[1]] == "."
          if grid[l[0] + dir[0]][l[1] + dir[1]] == "[" and dir[1] == 0
            locs.append([l[0] + dir[0], l[1] + dir[1]])
            locs.append([l[0] + dir[0], l[1] + dir[1] + 1])
          end
          if grid[l[0] + dir[0]][l[1] + dir[1]] == "]" and dir[1] == 0
            locs.append([l[0] + dir[0], l[1] + dir[1]])
            locs.append([l[0] + dir[0], l[1] + dir[1] - 1])
          end
          if grid[l[0] + dir[0]][l[1] + dir[1]] == "]" and dir[0] == 0
            locs.append([l[0] + dir[0], l[1] + dir[1]])
          end
          if grid[l[0] + dir[0]][l[1] + dir[1]] == "[" and dir[0] == 0
            locs.append([l[0] + dir[0], l[1] + dir[1]])
          end
          if grid[l[0] + dir[0]][l[1] + dir[1]] == "." or grid[l[0] + dir[0]][l[1] + dir[1]] == "#"
            locs.append([l[0] + dir[0], l[1] + dir[1]])
          end
        end

        allLocs += locs

        nextLocs = locs

        objs = locs.map { |l| grid[l[0]][l[1]] }

        nextObjs = objs

        if nextObjs.include? "#"
          break
        end
      end

    #   if iter == 0
    #     print nextLocs
    #     puts
    #   end

      allLocs += nextLocs

    #   if iter == 0
    #     print allLocs
    #     puts
    #   end

      if nextObjs.include? "#"
        # displayGrid(grid, robotLoc)
        # print robotLoc
        # puts 
        # puts
        next
      else
        if not movedBox
          robotLoc = [robotLoc[0] + dir[0], robotLoc[1] + dir[1]]
          grid[robotLoc[0]][robotLoc[1]] = "."
        #   displayGrid(grid, robotLoc)
        #   print robotLoc
        #   puts 
        #   puts
          next
        end

        temps = {}
        dots = []
        for i in 0...allLocs.length
          l = allLocs[i]
          temps[l] = grid[l[0]][l[1]]
          if temps[l] == "[" or temps[l] == "]"
            dots.append(l)
          end
        end

        for i in 0...dots.length
          l = dots[i]
          grid[l[0]][l[1]] = "."
        end

        for i in 0...dots.length
          l = dots[i]
          grid[l[0] + dir[0]][l[1] + dir[1]] = temps[l]
        end

        # for i in 0...allLocs.length
        #   l = allLocs[i]
        #   fromL = [l[0] - dir[0], l[1] - dir[1]]
        #   if dots.include? l
        #     grid[l[0]][l[1]] = "."
        #   end
        #   if temps[fromL]
        #     grid[l[0]][l[1]] = temps[fromL]
        #   else
        #     grid[l[0]][l[1]] = grid[fromL[0]][fromL[1]]
        #   end
        # end

        robotLoc = [robotLoc[0] + dir[0], robotLoc[1] + dir[1]]
        grid[robotLoc[0]][robotLoc[1]] = "."

      end

    #   displayGrid(grid, robotLoc)
    #   print robotLoc
    #   puts 
    #   puts


    end

    gps = 0

    for i in 0...grid.length
      for j in 0...grid[i].length
        if grid[i][j] == "["
          gps += 100 * i + j
        end
      end
    end

    return gps
end

# puts part1(data)
puts part2(data)