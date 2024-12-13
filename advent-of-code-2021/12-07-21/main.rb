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
  nums = input[0].split(",").map { |i| i.to_i }
  minFuel = Float::INFINITY
  for average in nums.min..nums.max
    minFuel = [minFuel, nums.inject(0) { |sum, i| sum += (average - i).abs }].min
  end
  return minFuel
end

def calcTriNum(n)
  return n * (n + 1) / 2
end

def part2(input)
  nums = input[0].split(",").map { |i| i.to_i }
  minFuel = Float::INFINITY
  for average in nums.min..nums.max
    minFuel = [minFuel, nums.inject(0) { |sum, i| sum += calcTriNum((average - i).abs) }].min
  end
  return minFuel
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)