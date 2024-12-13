fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def part1(input)
  nums = input.map { |i| i.to_i }
  locations = {}
  for i in 0...nums.length
    locations[i] = i
  end
  print nums
  puts
  #nums = [4, -2, 5, 6, 7, 8, 9]
  for i in 0...nums.length
    index = locations[i]
    cur = nums[index]
    nums.delete_at(index)
    toIndex = (cur + index) % nums.length
    if toIndex == 0 and cur < 0
      toIndex = nums.length
    end
    nums.insert(toIndex, cur)
    for j in locations.keys
      if locations[j] > index and locations[j] <= toIndex
        locations[j] -= 1
      end
      if locations[j] < index and locations[j] >= toIndex
        locations[j] += 1
      end
    end
    locations[i] = toIndex
  end
  zeroInd = nums.index(0)
  nums = nums.rotate(zeroInd)
  return nums[1000 % nums.length] + nums[2000 % nums.length] + nums[3000 % nums.length]
end

def part2(input)
  key = 811589153
  nums = input.map { |i| (i.to_i * key)}
  locations = {}
  for i in 0...nums.length
    locations[i] = i
  end
  #print nums
  #puts
  #nums = [4, -2, 5, 6, 7, 8, 9]
  for time in 0...10
    for i in 0...nums.length
      index = locations[i]
      cur = nums[index]
      nums.delete_at(index)
      toIndex = (cur + index) % nums.length
      if toIndex == 0 and cur < 0
        toIndex = nums.length
      end
      nums.insert(toIndex, cur)
      for j in locations.keys
        if locations[j] > index and locations[j] <= toIndex
          locations[j] -= 1
        end
        if locations[j] < index and locations[j] >= toIndex
          locations[j] += 1
        end
      end
      locations[i] = toIndex
    end
  end
  zeroInd = nums.index(0)
  nums = nums.rotate(zeroInd)
  return nums[1000 % nums.length] + nums[2000 % nums.length] + nums[3000 % nums.length]
end

#puts part1(data)
puts part2(data)