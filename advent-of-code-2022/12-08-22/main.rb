fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip.split("").map { |j| j.to_i }
  end
end

def isVisible(row, col, grid)
  h = grid[row][col]
  above = grid.slice(0, row).map { |i| i[col] }
  return true if above.all? { |i| i < h }
  below = grid.slice(row + 1, grid.length - row - 1).map { |i| i[col] }
  return true if below.all? { |i| i < h }
  left = grid[row].slice(0, col)
  return true if left.all? { |i| i < h }
  right = grid[row].slice(col + 1, grid[row].length - col - 1)
  return true if right.all? { |i| i < h }
  return false
end

def part1(input)
  visible = 2 * input.length + 2 * input[0].length - 4
  for row in 1...(input.length - 1)
    for col in 1...(input[row].length - 1)
      if isVisible(row, col, input)
        visible += 1
      end
    end
  end
  return visible
end

def getScore(row, col, grid)
  h = grid[row][col]
  above = grid.slice(0, row).map { |i| i[col] }.reverse.take_while { |i| i < h }
  numAbove = above.length + 1
  if numAbove > row
    numAbove = row
  end
  #puts numAbove
  below = grid.slice(row + 1, grid.length - row - 1).map { |i| i[col] }.take_while { |i| i < h }
  numBelow = below.length + 1
  if numBelow > grid.length - row - 1
    numBelow = grid.length - row - 1
  end
  #puts numBelow
  left = grid[row].slice(0, col).reverse.take_while { |i| i < h }
  numLeft = left.length + 1
  if numLeft > col
    numLeft = col
  end
  #puts numLeft
  right = grid[row].slice(col + 1, grid[row].length - col - 1).take_while { |i| i < h }
  numRight = right.length + 1
  if numRight > grid[row].length - col - 1
    numRight = grid[row].length - col - 1
  end
  #puts numRight
  #puts
  return numAbove * numBelow * numRight * numLeft
end

def part2(input)
  maxScore = -1
  for row in 1...(input.length - 1)
    for col in 1...(input[row].length - 1)
      score = getScore(row, col, input)
      #puts score
      maxScore = [maxScore, score].max
    end
  end
  return maxScore
end

puts part1(data)
puts part2(data)