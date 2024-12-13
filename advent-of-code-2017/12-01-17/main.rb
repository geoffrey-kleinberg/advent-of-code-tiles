require 'set'

day = "01"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    total = 0
    nums = input[0].split("").map { |i| i.to_i }
    for i in 0...nums.length
      if nums[i] == nums[(i + 1) % nums.length]
        total += nums[i]
      end
    end

    return total
end

def part2(input)
    total = 0
    nums = input[0].split("").map { |i| i.to_i }
    halfLen = nums.length / 2
    for i in 0...nums.length
      if nums[i] == nums[(i + halfLen) % nums.length]
        total += nums[i]
      end
    end

    return total
end

puts part1(data)
puts part2(data)