require 'set'

day = "21"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getNum(grid)
  return grid.flatten.join.to_i(2)
end

def flip(grid)
  return grid.map { |i| i.reverse }
end

# CCW
def rotateGrid(grid)
  newGrid = []
  for i in 0...grid.length
    newGrid[i] = grid.map { |j| j[grid.length - i - 1] }
  end
  return newGrid
end

# 141 too low
# 143 is wrong
# 145 too high

def part1(input)
    # store each picture as a binary number
    # 2x2 goes from 0 -> 15
    # 3x3 goes from 0 -> 512

    conversions2 = {}
    conversions3 = {}

    for line in input
      from, to = line.split(" => ")
      from = from.split("/").map { |i| i.split("").map { |j| j == "#" ? "1" : "0" } }
      to = to.split("/").map { |i| i.split("").map { |j| j == "#" ? "1" : "0" } }

      for r in 0...4
        
        rep = getNum(from)

        if from.length == 2
          conversions2[rep] = to
        end
        if from.length == 3
          conversions3[rep] = to
        end

        if from.length == 3

            flippedNum = getNum(flip(from))
            conversions3[flippedNum] = to

        end

        break if r == 3

        from = rotateGrid(from)
      end
    end

    grid = ["010", "001", "111"].map { |i| i.split("") }

    5.times do |iter|
      if grid.size % 2 == 0
        nextGrid = []
        (0...grid.length).step(2) do |i|
          3.times { nextGrid.append([]) }
          (0...grid.length).step(2) do |j|
            curGrid = grid[i..(i+1)].map { |l| l[j..(j+1)] }
            ins = conversions2[getNum(curGrid)]
            for k in 0...3
              nextGrid[-3 + k] += ins[k]
            end
          end
        end
      elsif grid.size % 3 == 0
        nextGrid = []
        (0...grid.length).step(3) do |i|
          4.times { nextGrid.append([]) }
          (0...grid.length).step(3) do |j|
            curGrid = grid[i..(i+2)].map { |l| l[j..(j+2)] }
            ins = conversions3[getNum(curGrid)]
            for k in 0...4
              nextGrid[-4 + k] += ins[k]
            end
          end
        end
      end

      grid = nextGrid

    #   puts grid.size

    #   puts grid.map { |i| i.join }
    #   puts
    end

    return grid.flatten.count("1")
end

def part2(input)
    conversions2 = {}
    conversions3 = {}

    for line in input
      from, to = line.split(" => ")
      from = from.split("/").map { |i| i.split("").map { |j| j == "#" ? "1" : "0" } }
      to = to.split("/").map { |i| i.split("").map { |j| j == "#" ? "1" : "0" } }

      for r in 0...4
        
        rep = getNum(from)

        if from.length == 2
          conversions2[rep] = to
        end
        if from.length == 3
          conversions3[rep] = to
        end

        if from.length == 3

            flippedNum = getNum(flip(from))
            conversions3[flippedNum] = to

        end

        break if r == 3

        from = rotateGrid(from)
      end
    end

    grid = ["010", "001", "111"].map { |i| i.split("") }

    18.times do |iter|
      if grid.size % 2 == 0
        nextGrid = []
        (0...grid.length).step(2) do |i|
          3.times { nextGrid.append([]) }
          (0...grid.length).step(2) do |j|
            curGrid = grid[i..(i+1)].map { |l| l[j..(j+1)] }
            ins = conversions2[getNum(curGrid)]
            for k in 0...3
              nextGrid[-3 + k] += ins[k]
            end
          end
        end
      elsif grid.size % 3 == 0
        nextGrid = []
        (0...grid.length).step(3) do |i|
          4.times { nextGrid.append([]) }
          (0...grid.length).step(3) do |j|
            curGrid = grid[i..(i+2)].map { |l| l[j..(j+2)] }
            ins = conversions3[getNum(curGrid)]
            for k in 0...4
              nextGrid[-4 + k] += ins[k]
            end
          end
        end
      end

      grid = nextGrid

    #   puts grid.size

    #   puts grid.map { |i| i.join }
    #   puts
    end

    return grid.flatten.count("1")
end

# puts part1(data)
puts part2(data)