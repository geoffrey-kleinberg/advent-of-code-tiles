require 'set'

day = "20"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  nums = 10
  nums = 4294967296
  ranges = [[0, nums - 1]]

  for line in input
    nextRanges = []
    low, high = line.split('-').map { |i| i.to_i }

    for i in 0...ranges.length
      first = ranges[i][0]
      last = ranges[i][1]
      if high < first
        nextRanges.append(ranges[i])
      elsif high >= first and high < last
        if low <= first
          r1 = [high + 1, last]
          nextRanges.append(r1)
        elsif low > first and low < high
          r1 = [first, low - 1]
          nextRanges.append(r1)
          r2 = [high + 1, last]
          nextRanges.append(r2)
        end
      elsif high >= last
        if low <= first
          next
        elsif low > first and low <= last
          r1 = [first, low - 1]
          nextRanges.append(r1)
        elsif low > last
          nextRanges.append(ranges[i])
        end
      end
    end

    ranges = nextRanges

  end

  total = 0
  for r in ranges
    total += (r[1] - r[0]) + 1
  end

  puts total

  return ranges[0][0]
end

def part2(input)
  return input
end

puts part1(data)
# puts part2(data)