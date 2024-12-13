fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def part1(input)
  x = 1
  cycle = 1
  score = 0
  for i in input
    #puts cycle
    #puts x
    #puts
    if cycle % 40 == 20
      score += x * cycle
    end
    if i != "noop"
      cycle += 1
      #puts cycle
      #puts x
      #puts
      if cycle % 40 == 20
        score += x * cycle
      end
      x += i.split(" ")[1].to_i
    end
    cycle += 1
  end
  return score
end

def getCover(x)
  if x > 0 and x < 39
    return [x - 1, x, x + 1]
  elsif x == 0
    return [0, 1]
  elsif x == -1
    return [0]
  elsif x == 39
    return [38, 39]
  elsif x == 40
    return [40]
  else
    return []
  end
end

def part2(input)
  x = 1
  cover = getCover(x)
  cycle = 1
  board = []
  for i in 0...6
    board << []
  end
  for i in input
    if cover.include? ((cycle - 1) % 40)
      board[(cycle - 1) / 40][(cycle - 1) % 40] = "#"
    else
      board[(cycle - 1) / 40][(cycle - 1) % 40] = " "
    end
    if i != "noop"
      cycle += 1
      if cover.include? ((cycle - 1) % 40)
        board[(cycle - 1) / 40][(cycle - 1) % 40] = "#"
      else
        board[(cycle - 1) / 40][(cycle - 1) % 40] = " "
      end
      x += i.split(" ")[1].to_i
      cover = getCover(x)
    end
    cycle += 1
  end
  return board.map { |i| i.join }
end

#puts part1(data)
puts part2(data)