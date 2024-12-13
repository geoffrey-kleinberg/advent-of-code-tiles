require 'set'

day = "04"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    count = 0
    for line in input
      spl = line.split(" ")
      if spl.length == spl.uniq.length
        count += 1
      end
    end
    return count
end

def part2(input)
    count = 0
    for line in input
      spl = line.split(" ")
      if spl.length == spl.uniq { |i| i.split("").sort }.length
        count += 1
      end
    end
    return count
end

puts part1(data)
puts part2(data)