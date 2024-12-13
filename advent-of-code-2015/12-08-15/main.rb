def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def getLen(string)
  escaped = false
  count = 0
  for i in string.split("")
    count += 1
    
    if not escaped and i == '"'
      count -= 1
    end
    
    if escaped and i == 'x'
      count -= 2
    end
    
    if not escaped and i == '\\'
      count -= 1
      escaped = true
    elsif escaped
      escaped = false
    end
  end
  
  return count
  
end

def part1(input)
  codeCharacters = input.inject(0) { |sum, i| sum + i.length }
  stringLength = input.inject(0) do |sum, i|
    sum + getLen(i)
  end
  return codeCharacters - stringLength
end

def getLongLen(string)
  length = string.length + 2 + string.count('\\') + string.count('"')
end

def part2(input)
  codeCharacters = input.inject(0) { |sum, i| sum + i.length }
  stringLength = input.inject(0) do |sum, i|
    sum + getLongLen(i)
  end
  return stringLength - codeCharacters
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)