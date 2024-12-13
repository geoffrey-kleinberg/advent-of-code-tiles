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

def process(line, arr)
  if line.include? "turn on"
    turnOnRange(line, arr)
  elsif line.include? "turn off"
    turnOffRange(line, arr)
  elsif line.include? "toggle"
    toggleRange(line, arr)
  else
    return "bad"
  end
end

def turnOnRange(line, arr)
  start = getCoords(line, 2)
  last = getCoords(line, 4)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      turnOn(arr, i, j)
    end
  end
end

def turnOffRange(line, arr)
  start = getCoords(line, 2)
  last = getCoords(line, 4)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      turnOff(arr, i, j)
    end
  end
end

def toggleRange(line, arr)
  start = getCoords(line, 1)
  last = getCoords(line, 3)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      toggle(arr, i, j)
    end
  end
end

def getCoords(line, loc)
  return line.split(" ")[loc].split(",").map { |i| i.to_i }
end

def turnOn(arr, row, col)
  arr[row][col] = true
end

def turnOff(arr, row, col)
  arr[row][col] = false
end

def toggle(arr, row, col)
  arr[row][col] = !arr[row][col]
end

def part1(input)
  lights = []
  row = []
  1000.times { row << false }
  1000.times { lights << row.clone }
  for i in input
    process(i, lights)
  end

  
  return lights.flatten.count(true)
  
end

def processFancy(line, arr)
  if line.include? "turn on"
    turnOnRangeFancy(line, arr)
  elsif line.include? "turn off"
    turnOffRangeFancy(line, arr)
  elsif line.include? "toggle"
    toggleRangeFancy(line, arr)
  else
    return "bad"
  end
end

def turnOnRangeFancy(line, arr)
  start = getCoords(line, 2)
  last = getCoords(line, 4)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      turnOnFancy(arr, i, j)
    end
  end
end

def turnOffRangeFancy(line, arr)
  start = getCoords(line, 2)
  last = getCoords(line, 4)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      turnOffFancy(arr, i, j)
    end
  end
end

def toggleRangeFancy(line, arr)
  start = getCoords(line, 1)
  last = getCoords(line, 3)
  for i in start[0]..last[0]
    for j in start[1]..last[1]
      toggleFancy(arr, i, j)
    end
  end
end

def turnOnFancy(arr, row, col)
  arr[row][col] += 1
end

def turnOffFancy(arr, row, col)
  arr[row][col] -= 1
  arr[row][col] = 0 if arr[row][col] < 0
end

def toggleFancy(arr, row, col)
  arr[row][col] += 2
end

def part2(input)
  lights = []
  row = []
  1000.times { row << 0 }
  1000.times { lights << row.clone }
  for i in input
    processFancy(i, lights)
  end
  
  return lights.flatten.sum
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)

#Little bit of practice uncle bobbing my code
#didn't really like it, maybe because it's ruby
#maybe I could use polymorphism for those if statements

class LightBoard1
  
  def initialize()
    @lightBoard = []
    populateLightboard()
  end
  
  def getLit()
    return @lightBoard.flatten.count(true)
  end

  def processLine(line)
    if line.include? "turn on"
      turnOn(line)
    elsif line.include? "turn off"
      turnOff(line)
    elsif line.include? "toggle"
      toggle(line)
    end
  end

  private

  def populateLightboard()
    1000.times do |i|
      @lightBoard << []
      populateRow(@lightBoard[i])
    end
  end
  
  def populateRow(arr)
    1000.times { arr << false }
  end
  
  def turnOn(line)
    start, last = getCoords(line, 2), getCoords(line, 4)
    for i in start[0]..last[0]
      for j in start[1]..last[1]
        turnOnOne(i, j)
      end
    end
  end
  
  def turnOff(line)
    start, last = getCoords(line, 2), getCoords(line, 4)
    for i in start[0]..last[0]
      for j in start[1]..last[1]
        turnOffOne(i, j)
      end
    end
  end
  
  def toggle(line)
    start, last = getCoords(line, 1), getCoords(line, 3)
    for i in start[0]..last[0]
      for j in start[1]..last[1]
        toggleOne(i, j)
      end
    end
  end
  
  def getCoords(line, loc)
    return line.split(" ")[loc].split(",").map { |i| i.to_i }
  end
  
  def turnOnOne(x, y)
    @lightBoard[x][y] = true
  end
  
  def turnOffOne(x, y)
    @lightBoard[x][y] = false
  end
  
  def toggleOne(x, y)
    @lightBoard[x][y] = !@lightBoard[x][y]
  end
  
end

def ooPart1(input)
  lights = LightBoard1.new
  for i in input
    lights.processLine(i)
  end
  return lights.getLit()
end

puts ooPart1(sinput.clone)
puts ooPart1(input.clone)

