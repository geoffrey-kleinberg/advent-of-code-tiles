def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def part1(input)
  nums = input.map { |i| i.to_i }
  groupWeight = nums.sum / 3
  size = 1
  loop do
    groups = nums.combination(size).filter do |i|
      i.sum == groupWeight
    end
    if groups.length != 0
      return groups.map { |i| i.inject(1) { |prod, j| prod * j } }.min  
      break
    end
    size += 1
  end
end

def part2(input)
  nums = input.map { |i| i.to_i }
  groupWeight = nums.sum / 4
  size = 1
  loop do
    groups = nums.combination(size).filter do |i|
      i.sum == groupWeight
    end
    if groups.length != 0
      return groups.map { |i| i.inject(1) { |prod, j| prod * j } }.min  
      break
    end
    size += 1
  end
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)