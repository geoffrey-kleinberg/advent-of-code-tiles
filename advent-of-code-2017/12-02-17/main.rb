require 'set'

day = "02"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    checkSum = 0
    for line in input
      nums = line.split(" ").map { |i| i.to_i }
      checkSum += nums.max - nums.min
    end
    return checkSum
end

def part2(input)
    checkSum = 0
    for line in input
      nums = line.split(" ").map { |i| i.to_i }
      for i in 0...nums.length
        for j in 0...nums.length
          next if nums[i] <= nums[j]
          if nums[i] % nums[j] == 0
            checkSum += (nums[i] / nums[j])
          end
        end
      end
    end
    return checkSum
end

puts part1(data)
puts part2(data)