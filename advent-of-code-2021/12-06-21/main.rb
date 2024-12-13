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

def solve(input, days)
  ages = input[0].split(",").map { |i| i.to_i }
  ageMap = ages.group_by { |i| i }.transform_values { |i| i.length }
  for i in 0...days
    newAMap = {}
    ageMap.each_key do |j|
      if j == 0
        (newAMap[6]) ? (newAMap[6] += ageMap[0]) : (newAMap[6] = ageMap[0])
        newAMap[8] = ageMap[0]
      else
        newAMap[j - 1] ? (newAMap[j - 1] += ageMap[j]) : (newAMap[j- 1] = ageMap[j])
      end
    end
    ageMap = newAMap.clone
  end
  return ageMap.values.sum
end


def part1(input)
  return solve(input, 80)
end

def part2(input)
  return solve(input, 256)
end


puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)

def naiveImplementation(input, days)
  ages = input[0].split(",").map { |i| i.to_i }
  for i in 0...days
    newAges = []
    for j in 0...ages.length
      if ages[j] == 0
        newAges << 8
        ages[j] = 7
      end
      ages[j] -= 1
    end
    newAges.each { |j| ages.append(j) }
    puts i if i % 10 == 0
  end
  return ages.length
end