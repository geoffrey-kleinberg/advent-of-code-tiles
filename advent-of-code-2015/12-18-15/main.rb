file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getNeighbors(i, j, height, length)
  neighbors = []
  for a in -1..1
    for b in -1..1
      newI = i + a
      newJ = j + b
      next if a == 0 and b == 0
      if newI >= 0 and newJ >= 0 and newI < height and newJ < length
        neighbors << [newI, newJ]
      end
    end
  end
  return neighbors
end

def iterate(grid)
  newGrid = grid.map { |i| i.clone }
  for i in 0...grid.length
    for j in 0...grid[i].length
      on = (grid[i][j] == "#")
      neighbors = getNeighbors(i, j, grid.length, grid[i].length)
      neighborsOn = 0
      for n in neighbors
        if grid[n[0]][n[1]] == "#"
          neighborsOn += 1
        end
      end
      if on and not [2, 3].include? neighborsOn
        newGrid[i][j] = "."
      elsif not on and neighborsOn == 3
        newGrid[i][j] = "#"
      end
    end
  end
  return newGrid
end

def part1(lines)
  grid = lines.map { |i| i.strip.split("") }
  height = grid.length
  length = grid[0].length
  
  steps = 4
  steps = 100
  
  for step in 0...steps
    grid = iterate(grid)
  end
  return grid.flatten.count("#")
end

def turnOnCorners(grid)
  height = grid.length
  length = grid[height - 1].length
  grid[0][0] = "#"
  grid[0][length - 1] = "#"
  grid[height - 1][0] = "#"
  grid[height - 1][length - 1] = "#"
  return grid
end

def part2(lines)
  grid = lines.map { |i| i.strip.split("") }
  height = grid.length
  length = grid[0].length
  
  steps = 5
  steps = 100
  
  for step in 0...steps
    grid = turnOnCorners(grid)
    #puts "after step #{step}"
    #grid.each do |i|
    #  puts i.join
    #end
    #puts
    grid = iterate(grid)
  end
  grid = turnOnCorners(grid)
  #puts "after step #{steps}"
  #grid.each do |i|
  #  puts i.join
  #end
  #puts
  return grid.flatten.count("#")
end

#puts part1(lines)
puts part2(lines)