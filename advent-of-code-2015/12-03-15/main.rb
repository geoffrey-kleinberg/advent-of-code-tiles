require 'set'

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
  current = [0, 0]
  visited = Set[current]
  for i in input[0].split("")
    changeCoord(current, i)
    visited.add(current.clone)
  end
  return visited.size
end

def changeCoord(arr, i)
  if i == '^'
    arr[1] += 1
  elsif i == '>'
    arr[0] += 1
  elsif i == '<'
    arr[0] -= 1
  elsif i == 'v'
    arr[1] -= 1
  else
    return "bad input"
  end
end

def part2(input)
  santaCurrent = [0, 0]
  roboSantaCurrent = [0, 0]
  doingSanta = true
  visited = Set[santaCurrent.clone]
  for i in input[0].split("")
    if doingSanta
      changeCoord(santaCurrent, i)
      visited.add(santaCurrent.clone)
    else
      changeCoord(roboSantaCurrent, i)
      visited.add(roboSantaCurrent.clone)
    end
    doingSanta = !doingSanta
  end
  return visited.size
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)