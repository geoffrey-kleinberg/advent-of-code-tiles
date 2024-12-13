def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def processIn(input)
  line = 0
  points = []
  while input[line] != ""
    points << input[line].split(",").map { |i| i.to_i }
    line += 1
  end
  line += 1
  folds = []
  while line < input.length
    fold = input[line].split(" ")[2]
    fold = fold.split("=")
    fold[1] = fold[1].to_i
    folds << fold
    line += 1
  end
  return [points, folds]
end

def getMax(points)
  maxX = points.max { |a, b| a[0] <=> b[0] }[0]
  maxY = points.max { |a, b| a[1] <=> b[1] }[1]
  return [maxX, maxY]
end

def fold(grid, fold)
  newGrid = []
  if fold[0] == 'x'
    for i in 0...grid.length
      newGrid << [0] * (grid[i].length / 2)
    end
    for i in 0...grid.length
      for j in 0...grid[i].length
        if j > fold[1]
          newGrid[i][2 * fold[1] - j] = grid[i][j] | newGrid[i][2 * fold[1] - j]
        elsif j < fold[1]
          newGrid[i][j] = grid[i][j] | newGrid[i][j]
        end
      end
    end
  else
    for i in 0...((grid.length - 1) / 2)
      newGrid << [0] * grid[i].length
    end
    for i in 0...grid.length
      for j in 0...grid[i].length
        if i > fold[1]
          newGrid[2 * fold[1] - i][j] = grid[i][j] | newGrid[2 * fold[1] - i][j]
        elsif i < fold[1]
          newGrid[i][j] = grid[i][j] | newGrid[i][j]
        end
      end
    end
  end
  return newGrid
end

def part1(input)
  points, folds = processIn(input)
  maxX, maxY = getMax(points)
  grid = []
  for i in 0..maxY
    grid << [0] * (maxX + 1)
  end
  for i in points
    grid[i[1]][i[0]] = 1
  end
  grid = fold(grid, folds[0])
  return grid.flatten.sum
end

def part2(input)
  points, folds = processIn(input)
  maxX, maxY = getMax(points)
  grid = []
  for i in 0..maxY
    grid << [0] * (maxX + 1)
  end
  for i in points
    grid[i[1]][i[0]] = 1
  end
  for i in folds
    grid = fold(grid, i)
  end
  grid.each { |i|
    puts i.map { |j| (j == 1) ? "#" : "." }.join
  }
  return nil
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)