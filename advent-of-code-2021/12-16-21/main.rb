require_relative 'packet'

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

def part1(input)
  packet = Packet.new(Packet.hexToBin(input[0]))
  return packet.getVersionSum
end

def part2(input)
  binary = Packet.hexToBin(input[0])
  packet = nil
  if Packet.getType(binary) == 0
    packet = SumPacket.new(binary)
  elsif Packet.getType(binary) == 1
    packet = ProductPacket.new(binary)
  elsif Packet.getType(binary) == 2
    packet = MinPacket.new(binary)
  elsif Packet.getType(binary) == 3
    packet = MaxPacket.new(binary)
  elsif Packet.getType(binary) == 4
    packet = LiteralPacket.new(binary)
  elsif Packet.getType(binary) == 5
    packet = GreaterPacket.new(binary)
  elsif Packet.getType(binary) == 6
    packet = LessPacket.new(binary)
  elsif Packet.getType(binary) == 7
    packet = EqualPacket.new(binary)
  end
  return packet.getValue
end

puts part1(sinput.clone)
#16

puts part1(input.clone)
#901

puts

puts part2(sinput.clone)
#15

puts part2(input.clone)
#110434737925
