require 'set'

day = "16"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  str = input[0]
  discLen = 20
  discLen = 272

  while str.length < discLen
    str = str + '0' + str.reverse.split("").map { |i| i == "0" ? "1" : "0" }.join
  end
  
  str = str.slice(0, discLen)
  while str.length % 2 == 0
    nextStr = ""
    (0...str.length).step(2) do |i|
      nextStr += str.slice(i) == str.slice(i + 1) ? "1" : "0"
    end
    str = nextStr
  end

  return str
end

def part2(input)
  str = input[0].split("").map { |i| i.to_i }
  discLen = 20
  discLen = 35651584

  i = str.length
  nextOff = str.length

  while i < discLen
    if i == nextOff
      str[i] = 0
      nextOff = nextOff * 2 + 1
    else
      str[i] = 1 - str[nextOff - i - 1]
    end
    i += 1
  end

  puts 'made str'

  while str.length % 2 == 0
    nextStr = []
    (0...str.length).step(2) do |i|
      nextStr.append(1 - (str.slice(i) ^ str.slice(i + 1)))
    end
    str = nextStr.clone
    puts str.length
  end

  return str.join
end

# puts part1(data)
puts part2(data)