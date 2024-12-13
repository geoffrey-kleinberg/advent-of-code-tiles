require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end


#825 is wrong
def part1(input)
  filled = Set[]
  for i in input
    corners = i.split(" -> ").map { |c| c.split(",").map { |x| x.to_i } }
    for j in 0...(corners.length - 1)
      if corners[j][0] == corners[j + 1][0]
        add = 1
        if corners[j][1] > corners[j + 1][1]
          add = -1
        end
        loc = corners[j][1]
        while loc != corners[j + 1][1]
          filled.add([corners[j][0], loc])
          loc += add
        end
      else
        add = 1
        if corners[j][0] > corners[j + 1][0]
          add = -1
        end
        loc = corners[j][0]
        while loc != corners[j + 1][0]
          filled.add([loc, corners[j][1]])
          loc += add
        end
      end
    end
    filled.add(corners[corners.length - 1])
  end
  #print filled
  #puts
  lowest = (filled.to_a.max { |j, k| j[1] <=> k[1] })[1]
  sandNo = 0
  while true
    sandLoc = [500, 0]
    while true
      if sandLoc[1] > lowest
        break
      end
      if not filled.include? [sandLoc[0], sandLoc[1] + 1]
        sandLoc[1] += 1
      elsif not filled.include? [sandLoc[0] - 1, sandLoc[1] + 1]
        sandLoc[0] -= 1
        sandLoc[1] += 1
      elsif not filled.include? [sandLoc[0] + 1, sandLoc[1] + 1]
        sandLoc[0] += 1
        sandLoc[1] += 1
      else
        break
      end
    end
    break if sandLoc[1] > lowest
    
    filled.add(sandLoc)
    sandNo += 1
    #puts sandNo
  end
    
  return sandNo
        
end

#15714 is wrong
def part2(input)
  filled = Set[]
  for i in input
    corners = i.split(" -> ").map { |c| c.split(",").map { |x| x.to_i } }
    for j in 0...(corners.length - 1)
      if corners[j][0] == corners[j + 1][0]
        add = 1
        if corners[j][1] > corners[j + 1][1]
          add = -1
        end
        loc = corners[j][1]
        while loc != corners[j + 1][1]
          filled.add([corners[j][0], loc])
          loc += add
        end
      else
        add = 1
        if corners[j][0] > corners[j + 1][0]
          add = -1
        end
        loc = corners[j][0]
        while loc != corners[j + 1][0]
          filled.add([loc, corners[j][1]])
          loc += add
        end
      end
    end
    filled.add(corners[corners.length - 1])
  end
  lowest = (filled.to_a.max { |j, k| j[1] <=> k[1] })[1]
  #puts lowest
  sandNo = 0
  while true
    sandLoc = [500, 0]
    while true
      #if sandLoc[1] > lowest
      #  break
      #end
      break if sandLoc[1] == lowest + 1
      if not filled.include? [sandLoc[0], sandLoc[1] + 1]
        sandLoc[1] += 1
      elsif not filled.include? [sandLoc[0] - 1, sandLoc[1] + 1]
        sandLoc[0] -= 1
        sandLoc[1] += 1
      elsif not filled.include? [sandLoc[0] + 1, sandLoc[1] + 1]
        sandLoc[0] += 1
        sandLoc[1] += 1
      else
        break
      end
    end
    #break if sandLoc[1] > lowest
    
    #p sandLoc
    #puts
    filled.add(sandLoc)
    sandNo += 1
    break if sandLoc == [500, 0]
    #puts sandNo
  end
    
  return sandNo
end

puts part1(data)
puts part2(data)