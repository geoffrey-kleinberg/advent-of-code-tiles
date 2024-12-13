fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.rstrip
  end
end

def getStartStacks(input)
  lines = []
  num = 0
  for i in 0...input.length
    if input[i + 1] == ""
      num = (input[i].split(" ").map { |j| j.to_i }).max
      break
    end
    lines << input[i]
  end
  stacks = []
  for i in 1..num
    stacks << []
  end
  for i in lines
    for j in 0..(i.length / 4)
      nextAdd = i.slice(j * 4 + 1)
      nextAdd = (nextAdd == " ") ? nil : nextAdd
      stacks[j].prepend(nextAdd)
    end
  end
  return stacks.map { |i| i.compact }
end

def getInstructions(input)
  ins = []
  start = false
  for i in 0...input.length
    if start
      ins << input[i]
    end
    if input[i] == ""
      start = true
    end
  end
  return ins.map { |i| i.split(" ") }
end

def part1(input)
  startStacks = getStartStacks(input)
  instructions = getInstructions(input)
  for i in instructions
    count = i[1].to_i
    start = i[3].to_i - 1
    finish = i[5].to_i - 1
    
    startStacks[start].last(count).reverse.each { |j|
      startStacks[finish].append(j)
    }
    startStacks[start] = startStacks[start].reverse.drop(count).reverse
  end
  return startStacks.map { |i| i.last }.join
end

def part2(input)
  startStacks = getStartStacks(input)
  instructions = getInstructions(input)
  for i in instructions
    count = i[1].to_i
    start = i[3].to_i - 1
    finish = i[5].to_i - 1
    
    startStacks[start].last(count).each { |j|
      startStacks[finish].append(j)
    }
    startStacks[start] = startStacks[start].reverse.drop(count).reverse
  end
  return startStacks.map { |i| i.last }.join
end

puts part1(data)
puts part2(data)