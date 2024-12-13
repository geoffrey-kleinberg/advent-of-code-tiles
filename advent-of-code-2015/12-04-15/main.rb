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

require 'digest'

def part1(input)
  i = 1
  str = input[0]
  loop do
    return i if Digest::MD5.hexdigest(str + i.to_s).slice(0, 5) == '00000'
    i += 1
  end
end

def part2(input)
  i = 1
  str = input[0]
  loop do
    return i if Digest::MD5.hexdigest(str + i.to_s).slice(0, 6) == '000000'
    i += 1
  end
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)