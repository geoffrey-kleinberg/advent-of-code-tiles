require 'set'

day = "24"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    comps = []
    for line in input
      comps.append(line.split("/").map { |i| i.to_i })
    end

    queue = []
    bridges = []

    for c in comps
      if c.include? 0
        queue.append([Set[c], c[1]])
      end
    end

    while queue.length > 0
      cur = queue.shift
      curBridge = cur[0]
      curLast = cur[1]
      bridges.append(curBridge)

      for c in comps
        next if curBridge.include? c
        next if not c.include? curLast
        

        nextB = curBridge + Set[c]
        nextL = nil
        if c[0] == curLast
          nextL = c[1]
        else
          nextL = c[0]
        end

        queue.append([nextB, nextL])
      end


    end
 
    return bridges.map { |i| i.to_a.flatten.sum }.max
    
end

def part2(input)
    comps = []
    for line in input
      comps.append(line.split("/").map { |i| i.to_i })
    end

    queue = []
    bridges = []

    for c in comps
      if c.include? 0
        queue.append([Set[c], c[1]])
      end
    end

    while queue.length > 0
      cur = queue.shift
      curBridge = cur[0]
      curLast = cur[1]
      bridges.append(curBridge)

      for c in comps
        next if curBridge.include? c
        next if not c.include? curLast
        

        nextB = curBridge + Set[c]
        nextL = nil
        if c[0] == curLast
          nextL = c[1]
        else
          nextL = c[0]
        end

        queue.append([nextB, nextL])
      end


    end

    puts "got bridges"
 
    longestLength = bridges.max { |i, j| i.size <=> j.size }.size

    return bridges.filter { |i| i.length == longestLength }.map { |i| i.to_a.flatten.sum }.max
end

# puts part1(data)
puts part2(data)