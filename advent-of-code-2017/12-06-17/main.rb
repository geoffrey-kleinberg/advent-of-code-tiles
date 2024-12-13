require 'set'

day = "06"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    seen = Set[]

    counter = 0

    banks = input[0].split(" ").map { |i| i.to_i }

    while seen.add? banks
      
      biggestLoc = banks.index(banks.max)
      biggest = banks[biggestLoc]
      banks[biggestLoc] = 0

      for i in 0...banks.length
        toAdd = biggest / banks.length
        banks[i] += toAdd
      end

      for i in 0...(biggest % banks.length)
        banks[(biggestLoc + 1 + i) % banks.length] += 1
      end




      counter += 1
    end

    return counter
end

def part2(input)
    seen = {}

    counter = 0

    banks = input[0].split(" ").map { |i| i.to_i }

    while true
      if seen[banks]
        return counter - seen[banks]
      end
      seen[banks.clone] = counter
      
      biggestLoc = banks.index(banks.max)
      biggest = banks[biggestLoc]
      banks[biggestLoc] = 0

      for i in 0...banks.length
        toAdd = biggest / banks.length
        banks[i] += toAdd
      end

      for i in 0...(biggest % banks.length)
        banks[(biggestLoc + 1 + i) % banks.length] += 1
      end


      counter += 1
    end

end

# puts part1(data)
puts part2(data)