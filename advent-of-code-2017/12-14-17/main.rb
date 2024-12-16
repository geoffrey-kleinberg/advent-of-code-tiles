require 'set'

day = "14"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getKnotHash(str)
    nums = str.split('').map { |i| i.ord }

    nums += [17, 31, 73, 47, 23]

    hashSize = 256
    list = (0...hashSize).to_a

    stepSize = 0
    curPos = 0

    64.times do 
      for step in nums
        first = curPos
        last = curPos + step - 1
        midpt = first + (last - first + 1) / 2
        for j in first...midpt
            idx1 = j % hashSize
            idx2 = (last - (j - first)) % hashSize
            list[idx1], list[idx2] = list[idx2], list[idx1]
        end
        curPos += step + stepSize
        curPos %= hashSize
        stepSize += 1
      end
    end

    denseHash = []
    for i in 0...16
      denseHash.append(list[i * 16...((i + 1) * 16)].inject(0) { |res, j| res ^ j })
    end

    return denseHash.map { |i| i < 16 ? '0' + i.to_s(16) : i.to_s(16) }.join
end

def part1(input)
    used = 0
    keyString = input[0]

    for num in 0...128
      knotHash = getKnotHash(keyString + "-" + num.to_s)
      used += knotHash.to_i(16).to_s(2).count("1")
    end

    return used
end

def part2(input)
    keyString = input[0]

    usedLocs = Set[]

    for num in 0...128
      knotHash = getKnotHash(keyString + "-" + num.to_s)
      output = knotHash.to_i(16).to_s(2)
      while output.length != 128
        output = '0' + output
      end
      for j in 0...128
        if output[j] == "1"
          usedLocs.add([num, j])
        end
      end
    end

    # puts usedLocs.size

    regions = 0

    while usedLocs.size > 0
      seed = usedLocs.to_a[0]
      queue = [seed]

      while queue.length > 0
        cur = queue.shift
        usedLocs.delete(cur)

        for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]
          check = [cur[0] + dir[0], cur[1] + dir[1]]
          if usedLocs.include? check
            queue.append(check)
          end
        end
      end
      regions += 1
    end

    return regions
end

# puts part1(data)
puts part2(data)