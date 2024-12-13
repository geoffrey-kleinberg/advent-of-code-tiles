fileName = "samplein.txt"
fileName = "input.txt"
data = []
sums = []
no = 0
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
    if not sums[no]
      sums[no] = 0
    end
    sums[no] += i.strip.to_i
    if i == "\n"
      no += 1
    end
      
  end
end
puts sums.max(3).sum

def part1(input)
  input = input.map { |i| i.to_i }
  input.each do |i|
    #puts i
  end
  sum = input.inject { |sum, i| sum + i }
  return 0
end

def part2(input)
end

puts part1(data)
puts part2(data)