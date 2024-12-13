file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def combos(amount, sizes)
  return 1 if amount == 0
  return 0 if amount < 0
  sum = 0
  for i in 0...sizes.length
    sum += combos(amount - sizes[i], sizes.last(sizes.length - i - 1))
  end
  return sum
end

def part1(lines)
  sizes = lines.map { |i| i.to_i }
  need = 25
  need = 150
  return combos(need, sizes)
end

def comboArrs(amount, sizes)
  return [[]] if amount == 0
  return nil if amount < 0
  comboArrs = []
  for i in 0...sizes.length
    a = comboArrs(amount - sizes[i], sizes.last(sizes.length - i - 1))
    next if not a
    for j in a
      comboArrs << j + [sizes[i]]
    end
  end
  return comboArrs
end

def part2(lines)
  sizes = lines.map { |i| i.to_i }
  need = 25
  need = 150
  possible = comboArrs(need, sizes)
  minLen = (possible.map { |i| i.length }).min
  return possible.count { |i| i.length == minLen }
end

#puts part1(lines)
puts part2(lines)