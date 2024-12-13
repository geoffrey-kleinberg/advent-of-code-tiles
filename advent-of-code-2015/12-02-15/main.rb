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
  dimensionList = input.map { |i| i.split("x"). map { |j| j.to_i }}
  return dimensionList.inject(0) do |total, i|
    sides = [i[0] * i[1], i[0] * i[2], i[1] * i[2]]
    total + 2 * sides.sum + sides.min
  end
end

def part2(input)
  dimensionList = input.map { |i| i.split("x"). map { |j| j.to_i }}
  return dimensionList.inject(0) do |total, i|
    total + 2 * i.sum - 2 * i.max + i.inject(1) { |vol, j| vol * j }
  end
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)