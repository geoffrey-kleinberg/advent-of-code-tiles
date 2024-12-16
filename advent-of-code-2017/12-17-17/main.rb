require 'set'

day = "17"
file_name = "12-#{day}-17/sampleIn.txt"
# file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    step = 3
    step = 312
    
    buffer = [0]

    idx = 0
    num = 1

    2017.times do
      idx = (idx + step + 1) % buffer.length
      buffer.insert(idx, num)
      num += 1
    end

    return buffer[(buffer.index(2017) + 1) % buffer.length]
end

def part2(input)
    step = 312

    idx = 0
    after0 = nil
    num = 1

    50000000.times do
      idx = (idx + step) % num
      if idx == 0
        after0 = num
      end
      idx += 1
      num += 1
    end

    return after0
end

puts part1(data)
puts part2(data)