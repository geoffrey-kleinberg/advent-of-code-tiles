require 'set'

day = "11"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def recursiveNum(stone, depth, memo)
  if depth == 0
    return 1
  end
  if memo[[stone, depth]]
    return memo[[stone, depth]]
  end
  if stone == 0
    val = recursiveNum(1, depth - 1, memo)
    memo[[stone, depth]] = val
    return val
  elsif stone.to_s.length % 2 == 0
    stoneStr = stone.to_s
    stoneLen = stoneStr.length
    v1 = recursiveNum(stoneStr.slice(0, stoneLen / 2).to_i, depth - 1, memo)
    v2 = recursiveNum(stoneStr.slice(stoneLen / 2, stoneLen / 2).to_i, depth - 1, memo)
    val = v1 + v2
    memo[[stone, depth]] = val
    return val
  else
    val = recursiveNum(2024 * stone, depth - 1, memo)
    memo[[stone, depth]] = val
    return val
  end
end

def part1(input)
    stones = input[0].split(" ").map { |i| i.to_i }
    # for blink in 0...25
    #   newStones = []
    #   for s in stones
    #     string = s.to_s
    #     stringLen = string.length
    #     if s == 0
    #       newStones.append(1)
    #     elsif stringLen % 2 == 0
    #       newStones.append(string.slice(0, stringLen / 2).to_i)
    #       newStones.append(string.slice(stringLen / 2, stringLen / 2).to_i)
    #     else
    #       newStones.append(s * 2024)
    #     end
    #   end
    #   stones = newStones
    # #   print newStones
    # #   puts
    # end
    # return stones.length
    total = 0
    memo = {}
    for s in stones
      total += recursiveNum(s.to_i, 25, memo)
    end
    return total
end

def part2(input)
    stones = input[0].split(" ").map { |i| i.to_i }
    total = 0
    memo = {}
    for s in stones
      total += recursiveNum(s.to_i, 75, memo)
    end
    return total
end

puts part1(data)
puts part2(data)