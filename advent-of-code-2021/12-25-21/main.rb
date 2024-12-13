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

def step(cucumbers)
  move = false
  movedTo = Set[]
  movedFrom = Set[]
  for i in 0...cucumbers.length
    for j in 0...cucumbers[i].length
      next if movedTo.include? [i, j]
      if cucumbers[i][j] == ">"
        nextLoc = j + 1
        if nextLoc == cucumbers[i].length
          nextLoc = 0
        end
        if cucumbers[i][nextLoc] == "." and not movedFrom.include? [i, nextLoc]
          movedTo.add([i, nextLoc])
          movedFrom.add([i, j])
          cucumbers[i][nextLoc] = ">"
          cucumbers[i][j] = "."
          move = true
        end
      end
    end
  end
  movedFrom = Set[]
  movedTo = Set[]
  for i in 0...cucumbers.length
    for j in 0...cucumbers[i].length
      next if movedTo.include? [i, j]
      if cucumbers[i][j] == "v"
        nextLoc = i + 1
        if nextLoc == cucumbers.length
          nextLoc = 0
        end
        if cucumbers[nextLoc][j] == "." and not movedFrom.include? [nextLoc, j]
          movedTo.add([nextLoc, j])
          movedFrom.add([i, j])
          cucumbers[nextLoc][j] = "v"
          cucumbers[i][j] = "."
          move = true
        end
      end
    end
  end
  return move
end

def part1(input)
  input = input.map { |i| i.split("") }
  count = 0
  puts count
  loop do
    count += 1
    break if not step(input)
    puts count
  end
  return count
end

puts part1(sinput.clone)
puts part1(input.clone)

puts