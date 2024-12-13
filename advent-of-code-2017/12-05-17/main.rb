require 'set'

day = "05"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    jumps = input.map { |i| i.to_i }
    pos = 0
    counter = 0
    while pos < jumps.length
      jumps[pos] += 1
      pos += jumps[pos] - 1
      counter += 1
    end
    return counter
end

def part2(input)
    jumps = input.map { |i| i.to_i }
    pos = 0
    counter = 0
    while pos < jumps.length
      if jumps[pos] >= 3
        jumps[pos] -= 1
        pos += jumps[pos] + 1
      else
        jumps[pos] += 1
        pos += jumps[pos] - 1
      end
      counter += 1
    end
    return counter
end

puts part1(data)
puts part2(data)