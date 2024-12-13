require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def part1(input)
  count = 0
  for line in input
    elves = line.split(",")
    elf1 = elves[0].split("-").map { |i| i.to_i }
    elf2 = elves[1].split("-").map { |i| i.to_i }
    if elf1[0] <= elf2[0] and elf1[1] >= elf2[1]
      count += 1
    elsif elf1[0] >= elf2[0] and elf1[1] <= elf2[1]
      count += 1
    end
  end
  return count
end

def part2(input)
  overlaps = 0
  for line in input
    elves = line.split(",")
    elf1 = elves[0].split("-").map { |i| i.to_i }
    elf2 = elves[1].split("-").map { |i| i.to_i }
    for i in elf1[0]..elf1[1]
      if i <= elf2[1] and i >= elf2[0]
        overlaps += 1
        break
      end
    end
  end
  return overlaps
end

puts part1(data)
puts part2(data)