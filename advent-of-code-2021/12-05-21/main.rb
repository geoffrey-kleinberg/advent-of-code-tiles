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

def count2(arr)
  return arr.count { |i| i and i >= 2 }
end

def part1(input)
  splitIn = []
  field = []
  for i in input
    splitIn.append(i.split(" -> ").map { |k| k.split(",").map { |i| i.to_i } })
  end
  #splitIn.map { |j| j.map! { |k| k.split(",").map { |i| i.to_i } } }
  maxNum = splitIn.flatten.max
  
  for i in 0..maxNum
    field << []
  end
  diag = []
  for i in splitIn
    if i[0][0] == i[1][0]
      coords = [i[0][1], i[1][1]]
      for j in coords.min..coords.max
        (field[j][i[0][0]] == nil) ? (field[j][i[0][0]] = 1) : (field[j][i[0][0]] += 1)
      end
    elsif i[0][1] == i[1][1]
      y = i[0][1]
      coords = [i[0][0], i[1][0]]
      for j in coords.min..coords.max
        (field[y][j] == nil) ? (field[y][j] = 1) : (field[y][j] +=1)
      end
    else
      diag << i
    end
  end
  yield field, diag
  return count2(field.flatten)
end

def getBetween(ps)
  start = ps.min { |i, j| i[0] <=> j[0] }
  finish = ps.max { |i, j| i[0] <=> j[0] }
  diag = []
  if start[1] > finish[1]
    x = start[0]
    y = start[1]
    while x <= finish[0]
      diag << [x, y]
      x += 1
      y -= 1
    end
  else
    x = start[0]
    y = start[1]
    while x <= finish[0]
      diag << [x, y]
      x += 1
      y += 1
    end
  end
  return diag
end

def part2(input)
  field = []
  diags = []
  part1(input) do |i, j|
    field = i
    diags = j
  end
  for i in diags
    for j in getBetween(i)
      y = j[1]
      x = j[0]
      (field[y][x] == nil) ? (field[y][x] = 1) : (field[y][x] += 1)
    end
  end
  return count2(field.flatten)
end

puts part1(sinput.clone) { |i, j| i }
puts part1(input.clone) { |i, j| i }

puts

puts part2(sinput.clone)
puts part2(input.clone)