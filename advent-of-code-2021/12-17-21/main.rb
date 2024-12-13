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

def changePosition(xPos, yPos, xVel, yVel)
  return [xPos + xVel, yPos + yVel]
end

def applyDrag(xVel)
  if xVel > 0
    return xVel - 1
  elsif xVel < 0
    return xVel + 1
  else
    return xVel
  end
end

def sumFrom(a, b)
  a -= 1
  return (b * (b + 1) - a * (a + 1)) / 2
end

def hitsTarget(xVel, yVel, xMin, xMax, yMin, yMax)
  xPos = 0
  if yVel > 0
    finalXVel = [xVel - 2 * yVel - 1, 0].max
    xPos = sumFrom(finalXVel + 1, xVel)
    xVel = finalXVel
    yVel *= -1
    yVel -= 1
  end
  yPos = 0
  loop do
    xPos, yPos = changePosition(xPos, yPos, xVel, yVel)
    xVel = applyDrag(xVel)
    yVel -= 1
    if xMin <= xPos and xMax >= xPos and yMin <= yPos and yMax >= yPos
      return true
    end
    if xVel == 0 and yPos < yMin
      return false if yPos < yMin
    end
  end
end

def triangular(n)
  return n * (n + 1) / 2
end

def inverseTriangular(m)
  return Math.sqrt(0.25 + 2 * m) - 0.5
end

def part1(input)
  box = input[0].split(": ")[1]
  yRange = box.split(", ")[1]
  yMin = yRange.split("=")[1].split("..")[0].to_i
  return triangular(yMin)
end

def part2(input)
  box = input[0].split(": ")[1]
  xRange = box.split(", ")[0]
  yRange = box.split(", ")[1]
  xMin = xRange.split("=")[1].split("..")[0].to_i
  xMax = xRange.split("=")[1].split("..")[1].to_i
  yMin = yRange.split("=")[1].split("..")[0].to_i
  yMax = yRange.split("=")[1].split("..")[1].to_i
  xVelMin = inverseTriangular(xMin).ceil
  xVelMax = xMax
  yVelMax = -1 * yMin - 1
  yVelMin = yMin
  works = 0
  testYVel = yMin
  while testYVel <= yVelMax
    testXVel = xVelMin
    while testXVel <= xVelMax
      if hitsTarget(testXVel, testYVel, xMin, xMax, yMin, yMax)
        works += 1
      end
      testXVel += 1
    end
    testYVel += 1
  end
  return works
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)