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

def getFactors(number, primes, prev)
  startTime = Time.now
  factors = [1]
  mapStart = Time.now
  facMap = getFactorization(number, primes, prev)
  mapEnd = Time.now
  mapTime = mapEnd - mapStart
  facMap.keys.each do |factor|
    toAdd = []
    for i in factors
      power = 1
      while power <= facMap[factor]
        toAdd << i * factor ** power
        power += 1
      end
    end
    toAdd.each { |i| factors << i }
  end
  endTime = Time.now
  yield endTime - startTime - mapTime, mapTime
  return factors
end

def getFactorSum(number, primes, prev)
  startTime = Time.now
  total = 1
  mapStart = Time.now
  facMap = getFactorization(number, primes, prev)
  mapEnd = Time.now
  mapTime = mapEnd - mapStart
  facMap.keys.each do |factor|
    lastSum = 0
    for i in 1..facMap[factor]
      lastSum += total * (factor ** i)
    end
    total += lastSum
  end
  endTime = Time.now
  yield endTime - startTime - mapTime, mapTime
  return total
end

def addMap(m1, m2)
  map1 = m1.clone
  map2 = m2.clone
  for i in map1.keys
    map2[i] ? (map2[i] += map1[i]) : (map2[i] = map1[i])
  end
  return map2
end


def getFactorization(number, primes, prev)
  original = number
  facMap = {}
  for div in primes
    break if div > Math.sqrt(original)
    break if number == 1
    while number % div == 0
      facMap[div] ? (facMap[div] += 1) : (facMap[div] = 1)
      number /= div
      if prev[number]
        prev[original] = addMap(facMap, prev[number])
        return prev[original]
      end
    end
  end
  if facMap.keys.length == 0
    primes.append(number)
    facMap[number] = 1
  end
  prev[number] = facMap
  return facMap
end

def part1(input)
  num = input[0].to_i
  primes = []
  i = 2
  factorMap = []
  factorSumTime = 0
  mapTime = 0
  total = getFactorSum(i, primes, factorMap) do |k, l|
    factorSumTime += k
    mapTime += l
  end
  while total * 10 < num
    i += 1
    total = getFactorSum(i, primes, factorMap) do |k, l|
      factorSumTime += k
      mapTime += l
    end
  end
  puts factorSumTime
  puts factorSumTime / i
  puts
  puts mapTime
  puts mapTime / i
  return i
end

def part2(input)
  num = input[0].to_i
  primes = []
  i = 2
  factorArr = []
  factorTime = 0
  mapTime = 0
  loop do
    factors = getFactors(i, primes, factorArr) do |j, k|
      factorTime += j
      mapTime += k
    end
    factors = factors.delete_if { |j| j <= (i - 1) / 50}
    break if factors.sum * 11 >= num
    i += 1
  end
  puts factorTime
  puts factorTime / i
  puts
  puts mapTime
  puts mapTime / i
  return i
end

t = Time.now
puts part1(sinput.clone)
puts Time.now - t
puts
t = Time.now
puts part1(input.clone)
puts Time.now - t

puts

t = Time.now
puts part2(sinput.clone)
puts Time.now - t
puts
t = Time.now
puts part2(input.clone)
puts Time.now - t