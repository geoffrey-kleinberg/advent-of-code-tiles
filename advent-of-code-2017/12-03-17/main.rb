require 'set'

day = "03"
file_name = "12-#{day}-17/sampleIn.txt"
# file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getLoc(num)
    i = 1
    diag = 0
    while i * i < num
      diag += 1
      i += 2
    end
    
    diag -= 1

    right = diag + 1
    down = -1 * diag

    startNum = (i - 2) * (i - 2)

    # puts i

    for add in 1...(4 * (i - 2) + 4)
      if num == startNum + add
        return right, down
      end
      if add < (i - 2) + 1
        down += 1
      elsif add < 2 * (i - 2) + 2
        right -= 1
      elsif add < 3 * (i - 2) + 3
        down -= 1
      elsif add < 4 * (i - 2) + 4
        right += 1
      end
    end

    return right, down
end

def part1(input)
    num = 312051
    right, down = getLoc(num)
    return right.abs + down.abs
end

def part2(input)
    vals = {
        [0, 0] => 1
    }
    vals.default = 0

    num = 312051

    nextWrite = 2
    while true
      right, down = getLoc(nextWrite)

      val = 0

      for i in -1..1
        for j in -1..1
          val += vals[[right + i, down + j]]
        end
      end

      if val > num
        return val
      end
      vals[[right, down]] = val

      nextWrite += 1
    end
end

puts part1(data)
puts part2(data)