require 'set'

day = "25"
# file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

# 394 is too high
# 1 is wrong


def part1(input)
  # a lot done manually
  x = 0
  while true
    start = x + 282 * 9
    outs = []
    goal = 0
    while start != 0
      break if start % 2 != goal
      outs.append(start % 2)
      start /= 2
      goal = 1 - goal
    end
    if start == 0 and outs.last == 1
      print outs
      puts
      return x
    end
    x += 1
  end
end

puts part1(data)