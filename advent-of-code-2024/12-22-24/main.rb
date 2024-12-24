require 'set'

day = "22"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def nextStep(num)
  original = num
  v1 = original * 64
  num = v1 ^ num
  num %= 16777216

  v2 = num / 32
  num = v2 ^ num
  num %= 16777216

  v3 = num * 2048
  num = v3 ^ num
  num %= 16777216

  return num

end

def part1(input)
    total = 0
    for i in input
      i = i.to_i
      2000.times {
        i = nextStep(i)
      }
    #   puts i
      total += i
    end

    return total
end

def getBananas(sList, dList, vals)
  for i in 0...(dList.length - 4)
    if dList[i...(i + 4)] == vals
      return sList[i + 3] % 10
    end
  end
  return 0
end

def part2(input)


    deltaMaxes = {}

    iters = 2000

    for i in input
      i = i.to_i
      secretNum = i
      deltas = []
      bd = Set[]
      for t in 0...iters
        nextSecret = nextStep(secretNum)

        deltas.append((nextSecret % 10) - (secretNum % 10))
        if t >= 3
          deltSeq = deltas.join
          if bd.add? deltSeq
            if not deltaMaxes[deltSeq]
              deltaMaxes[deltSeq] = 0
            end
            deltaMaxes[deltSeq] += nextSecret % 10
          end
          deltas.delete_at(0)
        end

        secretNum = nextSecret
      end
    end

    return deltaMaxes.values.max


end

# puts part1(data)
puts part2(data)