require 'set'

day = "10"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    nums = input[0].split(',').map { |i| i.to_i }

    hashSize = 256
    list = (0...hashSize).to_a

    stepSize = 0
    curPos = 0
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

    return list[0] * list[1]
end

def part2(input)
    nums = input[0].split('').map { |i| i.ord }

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

# puts part1(data)
puts part2(data)