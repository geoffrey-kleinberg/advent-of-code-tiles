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

def part1(input)
  charPoints = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
  }
  openers = ["(", "[", "{", "<"]
  closers = [")", "]", "}", ">"]
  corruptedLines = []
  closeOpen = {
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }
  points = 0
  for i in input
    corrupted = false
    openOrder = []
    for j in i.split("")
      if openers.include? j
        openOrder << j
      end
      if closers.include? j
        if openOrder.last != closeOpen[j]
          corrupted = true
          points += charPoints[j]
          corruptedLines << i
          break
        else
          openOrder.delete_at(-1)
        end
      end
    end
  end
  yield corruptedLines
  return points
end

def part2(input)
  part1(input) { |i|
    i.each do |j|
      input.delete(j)
    end
  }
  openers = ["(", "[", "{", "<"]
  closers = [")", "]", "}", ">"]
  closeOpen = {
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
  }
  openClose = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
  }
  closeVal ={
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
  }
  scores = []
  for i in input
    openOrder = []
    opens = {
      "(" => 0,
      "[" => 0,
      "{" => 0,
      "<" => 0
    }
    for j in i.split("")
      if openers.include? j
        openOrder << j
        opens[j] += 1
      end
      if closers.include? j
        openOrder.delete_at(-1)
        opens[closeOpen[j]] -= 1
      end
    end
    completionString = openOrder.reverse.map { |j| openClose[j] }
    thisScore = completionString.inject(0) do |sum, closer|
      (sum * 5) + closeVal[closer]
    end
    scores << thisScore
  end
  
  return scores.sort[(scores.length - 1) / 2]
end

puts part1(sinput.clone) { |i| i }
puts part1(input.clone) { |i| i }

puts

puts part2(sinput.clone)
puts part2(input.clone)