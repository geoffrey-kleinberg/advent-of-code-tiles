require 'set'

day = "09"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    line = input[0].split('').map { |i| i.to_i }
    fileSizes = []
    breaks = []
    i = 0
    while i < line.length
      fileSizes.append(line[i])
      if i != line.length - 1
        breaks.append(line[i + 1])
      end
      i += 2
    end

    list = []

    lX = 0
    rX = fileSizes.length - 1

    lLoc = 0
    rLoc = fileSizes.length - 1

    for i in 0...fileSizes.sum
      if lLoc % 2 == 0
        list.append(lX)
      else
        list.append(rX)
        fileSizes[rLoc] -= 1
      end


      line[lLoc] -= 1

      while line[lLoc] == 0
        lLoc += 1
        if lLoc % 2 == 0
          lX += 1
        end
      end
      while fileSizes[rLoc] == 0
        rLoc -= 1
        rX -= 1
      end
    end

    checksum = 0

    for i in 0...list.length
      checksum += i * list[i]
    end

    # print list

    return checksum
end

# 8591361868443 is wrong

def part2(input)
    line = input[0].split('').map { |i| i.to_i }
    fileSizes = []
    breaks = []
    i = 0
    while i < line.length
      fileSizes.append(line[i])
      if i != line.length - 1
        breaks.append(line[i + 1])
      end
      i += 2
    end

    list = []
    empties = []
    full = []

    x = 0
    idx = 0

    for i in 0...line.length
      start = idx
      if i % 2 == 0
        for j in 0...line[i]
          list.append(x)
          idx += 1
        end
        if start <= idx - 1
          full.append([start, idx - 1])
        end
        x += 1
      else
        for j in 0...line[i]
          list.append(nil)
          idx += 1
        end
        if start <= idx - 1
          empties.append([start, idx - 1])
        end
      end
    end

    for i2 in 0...full.length
      i = full.length - i2 - 1

      len = full[i][1] - full[i][0] + 1
      for j in 0...empties.length
        space = empties[j][1] - empties[j][0] + 1
        if space >= len and empties[j][0] <= full[i][0]
          for k in empties[j][0]...(empties[j][0] + len)
            list[k] = i
          end
          for k in full[i][0]..full[i][1]
            list[k] = nil
          end
          empties[j][0] += len
          break
        end
      end
    end

    checksum = 0

    for i in 0...list.length
      next if list[i] == nil
      checksum += i * list[i]
    end

    return checksum

end

# puts part1(data)
puts part2(data)