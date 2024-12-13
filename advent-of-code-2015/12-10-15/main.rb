sinput = "1"
input = "3113322113"

def part1(input)
  lastChar = nil
  40.times do
    currentChar = input.slice(0)
    count = 0
    nextStr = ""
    for char in input.split("")
      if char == currentChar
        count += 1
      else
        nextStr += count.to_s + currentChar
        count = 1
        currentChar = char
      end
    end
    nextStr += count.to_s + currentChar
    input = nextStr
  end
  return input.length
end

def part2(input)
  lastChar = nil
  50.times do |r|
    currentChar = input.slice(0)
    count = 0
    nextStr = ""
    for i in 0...input.length
      char = input.slice(i)
      if char == currentChar
        count += 1
      else
        nextStr += count.to_s + currentChar
        count = 1
        currentChar = char
      end
    end
    nextStr += count.to_s + currentChar
    input = nextStr
    puts r
    puts input.length
  end
  return input.length
end

puts part1(sinput)
puts part1(input)

puts

puts part2(sinput)
puts part2(input)