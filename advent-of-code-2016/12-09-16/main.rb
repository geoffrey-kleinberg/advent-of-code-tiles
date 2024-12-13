require 'set'

day = "09"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    line = input[0]
    chars = 0
    loc = 0
    nextPattern = /\(\d+x\d+\)/.match(line)
    while nextPattern
      loc = nextPattern.begin(0)
      chars += loc
      vals = nextPattern[0].slice(1...-1).split("x").map { |i| i.to_i }
      chars += vals[0] * vals[1]
      loc += nextPattern[0].length + vals[0]


      line = line.slice(loc..-1)
      nextPattern = /\(\d+x\d+\)/.match(line)
    end
    chars += line.length
    return chars
end

def getDecompressedLen(line)
    nextPattern = /\(\d+x\d+\)/.match(line)
    if not nextPattern
      return line.length
    end
    chars = 0
    loc = 0
    while nextPattern
        loc = nextPattern.begin(0)
        chars += loc
        vals = nextPattern[0].slice(1...-1).split("x").map { |i| i.to_i }
        repeated = line.slice(loc + nextPattern[0].length, vals[0])
        chars += vals[1] * getDecompressedLen(repeated)
        loc += nextPattern[0].length + vals[0]
  
  
        line = line.slice(loc..-1)
        nextPattern = /\(\d+x\d+\)/.match(line)
    end
    chars += line.length
    return chars
end

def part2(input)
    return getDecompressedLen(input[0])
end

# puts part1(data)
puts part2(data)