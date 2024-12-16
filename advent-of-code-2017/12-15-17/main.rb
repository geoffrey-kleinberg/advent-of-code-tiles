require 'set'

day = "15"
file_name = "12-#{day}-17/sampleIn.txt"
# file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getLast16(num)
  return num.to_s(2)[-16..]
end

def part1(input)


    a, b = 65, 8921
    a, b = 703, 516

    multA, multB = 16807, 48271
    mod = 2147483647

    match = 0

    40000000.times do |i|
      if i % 1000000 == 0
        puts i
      end 
      a = (a * multA) % mod
      b = (b * multB) % mod
      
      aStr = getLast16(a)
      bStr = getLast16(b)

      if aStr == bStr
        match += 1
      end
      
    end

    return match

end

def part2(input)
    a, b = 65, 8921
    a, b = 703, 516

    multA, multB = 16807, 48271
    mod = 2147483647

    aVals = []
    bVals = []

    while aVals.length < 5000000
      a = (a * multA) % mod
      if a % 4 == 0
        aVals.append(a)
      end
    end

    puts "aVals"

    while bVals.length < 5000000
      b = (b * multB) % mod
      if b % 8 == 0
        bVals.append(b)
      end
    end

    puts "bVals"

    match = 0

    for i in 0...5000000
      if getLast16(aVals[i]) == getLast16(bVals[i])
        match += 1
      end
    end
    
    return match
end

# puts part1(data)
puts part2(data)