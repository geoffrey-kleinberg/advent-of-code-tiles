require 'set'

day = "14"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    robots = []
    iMax = 7
    jMax = 11
    iMax = 101
    jMax = 103
    for line in input
      spl = line.split(" ")
      p1, p2 = spl[0].split("=")[1].split(",").map { |i| i.to_i }
      v1, v2 = spl[1].split("=")[1].split(",").map { |i| i.to_i }
      robots.append([[p1, p2], [v1, v2]])
    end

    100.times do
      for r in robots
        r[0][0] = (r[0][0] + r[1][0]) % iMax
        r[0][1] = (r[0][1] + r[1][1]) % jMax
      end
    end

    sums = [0, 0, 0, 0]

    for i in 0...(iMax / 2)
      for j in 0...(jMax / 2)
        sums[0] += robots.count { |r| r[0] == [i, j] }
      end
    end
    for i in (iMax / 2 + 1)...(iMax)
      for j in 0...(jMax / 2)
        sums[1] += robots.count { |r| r[0] == [i, j] }
      end
    end
    for i in 0...(iMax / 2)
      for j in (jMax / 2 + 1)...(jMax)
        sums[2] += robots.count { |r| r[0] == [i, j] }
      end
    end
    for i in (iMax / 2 + 1)...(iMax)
      for j in (jMax / 2 + 1)...(jMax)
        sums[3] += robots.count { |r| r[0] == [i, j] }
      end
    end

    print sums
    puts

    return sums[0] * sums[1] * sums[2] * sums[3]
end

def part2(input)
    rLocs = []
    rVels = []
    iMax = 7
    jMax = 11
    iMax = 101
    jMax = 103
    for line in input
        spl = line.split(" ")
        p1, p2 = spl[0].split("=")[1].split(",").map { |i| i.to_i }
        v1, v2 = spl[1].split("=")[1].split(",").map { |i| i.to_i }
        rLocs.append([p1, p2])
        rVels.append([v1, v2])
    end


    count = 0

    while true
      locs = Set[]
      for r in 0...rLocs.length
        rLocs[r][0] = (rLocs[r][0] + rVels[r][0]) % iMax
        rLocs[r][1] = (rLocs[r][1] + rVels[r][1]) % jMax
        locs.add(rLocs[r])
      end
      count += 1
      display = false
      hLineLen = 11

      # check for a long enough horizontal line
      for i in 0...iMax
        for j in 0...(jMax - hLineLen)
          list = []
          for p in 0...hLineLen
            list.append([i, j + p])
          end
          if list.all? { |k| locs.include? k}
            display = true
          end
        end
      end
      next if not display
      for i in 0...iMax
        for j in 0...jMax
          if locs.include? [i, j]
            print "#"
          else
            print "."
          end
        end
        puts
      end
      return count
    end
end

# puts part1(data)
puts part2(data)