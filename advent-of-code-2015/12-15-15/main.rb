file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getQualities(lines)
  qualities = {}
  for i in lines
    splitLine = i.split(" ")
    qualities[splitLine[0].chop] = []
    for j in 1..5
      qualities[splitLine[0].chop] << splitLine[2 * j].to_i
    end
  end
  return qualities
end

def getAmounts(bars, amount)
  amounts = []
  total = 0
  for i in 0...(amount - 1)
    amounts[i] = bars[i] - i - total
    total += amounts[i]
  end
  amounts[amount - 1] = 100 - total
  return amounts
end

def sumProduct(arr1, arr2)
  sum = 0
  arr1.each.with_index do |i, ind|
    sum += i * arr2[ind]
  end
  return sum
end

def part1(lines)
  qualities = getQualities(lines)
  capacities = qualities.values.map { |i| i[0] }
  durabilities = qualities.values.map { |i| i[1] }
  flavors = qualities.values.map { |i| i[2] }
  textures = qualities.values.map { |i| i[3] }
  maxScore = 0
  bars = qualities.size - 1
  (0...(100 + bars)).to_a.combination(bars).each do |i|
    amounts = getAmounts(i, bars + 1)
    capScore = sumProduct(capacities, amounts)
    durScore = sumProduct(durabilities, amounts)
    flScore = sumProduct(flavors, amounts)
    textScore = sumProduct(textures, amounts)
    score = [capScore, 0].max * [durScore, 0].max * [flScore, 0].max * [textScore, 0].max
    if score > maxScore
      maxScore = score
    end
  end
  return maxScore
end

def part2(lines)
  qualities = getQualities(lines)
  capacities = qualities.values.map { |i| i[0] }
  durabilities = qualities.values.map { |i| i[1] }
  flavors = qualities.values.map { |i| i[2] }
  textures = qualities.values.map { |i| i[3] }
  calories = qualities.values.map { |i| i[4] }
  maxScore = 0
  bars = qualities.size - 1
  (0...(100 + bars)).to_a.combination(bars).each do |i|
    amounts = getAmounts(i, bars + 1)
    next if sumProduct(calories, amounts) != 500
    capScore = sumProduct(capacities, amounts)
    durScore = sumProduct(durabilities, amounts)
    flScore = sumProduct(flavors, amounts)
    textScore = sumProduct(textures, amounts)
    score = [capScore, 0].max * [durScore, 0].max * [flScore, 0].max * [textScore, 0].max
    if score > maxScore
      maxScore = score
    end
  end
  return maxScore
end

#puts part1(lines)
puts part2(lines)