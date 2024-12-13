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

class Integer
  
  def getMagnitude
    return self
  end
  
  def depth
    return 0
  end
  
  def toBin
    binStr = ""
    val = self
    while val > 0
      binStr = (val % 2).to_s + binStr
      val /= 2
    end
    return binStr.to_i
  end

  def toTen
    i = self.to_s.length
    return self.to_s.split("").inject(0) { |sum, val|
      sum + val.to_i * (2 ** (i -= 1) )
    }
  end
  
  def getOnPath(path)
    return self
  end
  
  def copy
    return self
  end

end

class Pair
  
  attr_accessor :left, :right
  
  def initialize(pair1, pair2)
    @left = pair1
    @right = pair2
    @leftDepth = pair1.depth + 1
    @rightDepth = pair2.depth + 1
  end
  
  def getMagnitude
    @magnitude = 3 * @left.getMagnitude + 2 * @right.getMagnitude
  end
  
  def + other
    return Pair.new(self, other).reduce
  end
  
  def depth
    @leftDepth = @left.depth + 1
    @rightDepth = @right.depth + 1
    return [@leftDepth, @rightDepth].max
  end
  
  def to_s
    return "[" + @left.to_s + "," + @right.to_s + "]"
  end
  
  def reduce
    self.explodeAll
    for i in 0...16
      path = i.toBin.to_s.split("").map { |j| (j == "0") ? "l" : "r"}
      while path.length != 4
        path.insert(0, "l")
      end
      val = self.getOnPath(path)
      if val >= 10
        newLeft = val / 2
        newRight = val - newLeft
        self.setPath(Pair.new(newLeft, newRight), path)
        self.reduce
      end
    end
    return self
  end
  
  def explodeAll
    while depth > 4
      exploder, path = self.getExplode(0, [])
      lPath = Pair.leftPath(path)
      rPath = Pair.rightPath(path)
      50.times { lPath.append("r") if lPath }
      50.times { rPath.append("l") if rPath }
      leftAdd = exploder.left
      rightAdd = exploder.right
      self.addOnPath(leftAdd, lPath)
      self.addOnPath(rightAdd, rPath)
      self.setPath(0, path)
    end
  end
  
  def getOnPath(path)
    if path.length == 1
      if path[0] == "l"
        return @left
      else
        return @right
      end
    else
      if path[0] == "l"
        return @left.getOnPath(path.slice(1, 100))
      else
        return @right.getOnPath(path.slice(1, 100))
      end
    end
  end
  
  def setPath(val, path)
    if path[0] == "l"
      if self.left.is_a? Integer
        self.left = val
        @leftDepth = 1
      elsif path.length != 1
        @left.setPath(val, path.slice(1, 100))
      else
        @left = val
        @depth = 0
      end
    else
      if self.right.is_a? Integer
        self.right = val
        @rightDepth = 1
      elsif path.length != 1
        @right.setPath(val, path.slice(1, 100))
      else
        @right = val
        @depth = 0
      end
    end
  end
  
  def addOnPath(val, path)
    return unless path
    if path[0] == "l"
      if @left.depth == 0
        @left += val
      else
        @left.addOnPath(val, path.slice(1, 100))
      end
    elsif path[0] == "r"
      if @right.depth == 0
        @right += val
      else
        @right.addOnPath(val, path.slice(1, 100))
      end
    end
  end
  
  def getExplode(layer, path)
    if layer == 4
      return [self, path]
    end
    if @left.depth == 4 - layer
      path << "l"
      return @left.getExplode(layer + 1, path)
    else
      path << "r"
      return @right.getExplode(layer + 1, path)
    end
  end
  
  def self.leftPath(path)
    if path.all? { |i| i == "l" }
      return nil
    end
    newPath = []
    newPath = (path.map { |i| (i == "l") ? "0" : "1" }.join.to_i.toTen - 1).toBin.to_s.split("").map { |i| i == "0" ? "l" : "r"}
    while newPath.length != 4
      newPath.insert(0, "l")
    end
    return newPath
  end
  
  def self.rightPath(path)
    if path.all? { |i| i == "r" }
      return nil
    end
    newPath = []
    newPath = (path.map { |i| (i == "l") ? "0" : "1" }.join.to_i.toTen + 1).toBin.to_s.split("").map { |i| i == "0" ? "l" : "r"}
    while newPath.length != 4
      newPath.insert(0, "l")
    end
    return newPath
  end
  
  def self.parsePair(string)
    openBrackets = 0
    commaLoc = nil
    left = nil
    right = nil
    for i in 0...string.length
      if string.slice(i) == "["
        openBrackets += 1
      end
      if string.slice(i) == ","
        commaLoc = i if openBrackets == 1
        if openBrackets == 1
          left = string.slice(1, i - 1)
          if left.include? ","
            left = Pair.parsePair(left)
          else
            left = left.to_i
          end
        end
      end
      if string.slice(i) == "]"
        if openBrackets == 1
          right = string.slice(commaLoc + 1, i - commaLoc - 1)
          if right.include? ","
            right = Pair.parsePair(right)
          else
            right = right.to_i
          end
        end
        openBrackets -= 1
      end
    end
    return Pair.new(left, right)
  end
  
  def copy
    return Pair.new(@left.copy, @right.copy)
  end
  
end


def part1(input)
  pair = Pair.parsePair(input[0])
  pair.reduce
  for i in 1...input.length
    pair += Pair.parsePair(input[i])
  end
  return pair.getMagnitude
end

def part2(input)
  maxMag = 0
  input = input.map { |i| Pair.parsePair(i) }
  for i in 0...input.length
    for j in 0...input.length
      next if i == j
      first = input[i].copy
      second = input[j].copy
      pair = first + second
      mag = pair.getMagnitude
      maxMag = [mag, maxMag].max
    end
  end
  return maxMag
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)