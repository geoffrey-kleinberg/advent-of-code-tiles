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
  return input[0].count("(") - input[0].count(")")
end

def part2(input)
  level = 0
  for i in 0...input[0].length
    if input[0][i] == "("
      level += 1
    else
      level -= 1
    end
    return (i + 1) if level < 0
  end
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)