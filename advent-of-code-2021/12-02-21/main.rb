lines = []
File.open("input.txt") do |f|
  f.each do |i|
    lines << i.split(" ").map.with_index { |i, j| (j == 0) ? i : i.to_i }
  end
end
def part1(lines)
  hPos = 0
  dPos = 0
  for i in lines
    if i[0] == "forward"
      hPos += i[1]
    elsif i[0] == "down"
      dPos += i[1]
    elsif i[0] == "up"
      dPos -= i[1]
    end
  end
  
  return dPos * hPos
end
def part2(lines)
  hPos = 0
  dPos = 0
  aim = 0
  for i in lines
    if i[0] == "forward"
       hPos += i[1]
       dPos += aim * i[1]
    elsif i[0] == "down"
      aim += i[1]
    elsif i[0] == "up"
      aim -= i[1]
    end
  end
  return dPos * hPos
end
puts part1(lines)
puts part2(lines)