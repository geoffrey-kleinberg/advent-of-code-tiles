class Packet
  
  @@sumNum = 0
  @@prodNum = 1
  @@minNum = 2
  @@maxNum = 3
  @@literalNum = 4
  @@greaterNum = 5
  @@lessNum = 6
  @@equalNum = 7
  
  @@versionStart = 0
  @@versionLen = 3
  
  @@typeStart = @@versionLen
  @@typeLen = 3
  
  @@literalPrefixLen = @@versionLen + @@typeLen
  @@lengthTypeIDLen = 1
  @@lengthTypeIDLoc = @@literalPrefixLen
  @@prefixLen = @@literalPrefixLen + @@lengthTypeIDLen
  
  @@literalTotalGroupSize = 5
  @@literalPrefixSize = 1
  @@literalGroupSize = @@literalTotalGroupSize - @@literalPrefixSize
  
  @@id0Length = 15
  @@id1Length = 11
  
  
  def initialize(binary)
    @binary = binary
    @version = Packet.binToTen(binary.slice(@@versionStart, @@versionLen))
    @subPackets = self.processSubPackets
  end
  
  def getValue
    raise "not implemented"
  end
  
  def getVersion
    return @version
  end
  
  def getVersionSum
    return @subPackets.map { |i| i.getVersionSum }.sum + @version
  end
  
  def self.getSubPackets(binary)
    if Packet.getType(binary) == @@literalNum
      packet = binary.slice(0, @@literalPrefixLen)
      i = 0
      while binary.slice(@@literalPrefixLen + @@literalTotalGroupSize * i) == "1"
        packet += binary.slice(@@literalPrefixLen + @@literalTotalGroupSize * i, @@literalTotalGroupSize)
        i += 1
      end
      packet += binary.slice(@@literalPrefixLen + @@literalTotalGroupSize * i, @@literalTotalGroupSize)
      return [packet]
    end
      
    lengthTypeID = binary.slice(@@lengthTypeIDLoc).to_i
    packets = []
    if lengthTypeID == 0
      subPacketLength = Packet.binToTen(binary.slice(@@prefixLen, @@id0Length))
      while packets.join.length != subPacketLength
        nextP = Packet.getSubPackets(binary.slice(@@prefixLen + @@id0Length + packets.join.length, 10 ** 10)).join
        packets << nextP
      end
      packets.insert(0, binary.slice(0, @@prefixLen + @@id0Length))
    else
      subPacketNum = Packet.binToTen(binary.slice(@@prefixLen, @@id1Length))
      for i in 0...subPacketNum
        nextP = Packet.getSubPackets(binary.slice(@@prefixLen + @@id1Length + packets.join.length, 10 ** 10)).join
        packets << nextP
      end
      packets.insert(0, binary.slice(0, @@prefixLen + @@id1Length))
    end
    return packets
  end
  
  def processSubPackets
    sps = []
    packets = Packet.getSubPackets(@binary)
    for i in packets.slice(1, packets.length - 1)
      if Packet.getType(i) == @@sumNum
        sps << SumPacket.new(i)
      elsif Packet.getType(i) == @@prodNum
        sps << ProductPacket.new(i)
      elsif Packet.getType(i) == @@minNum
        sps << MinPacket.new(i)
      elsif Packet.getType(i) == @@maxNum
        sps << MaxPacket.new(i)
      elsif Packet.getType(i) == @@literalNum
        sps << LiteralPacket.new(i)
      elsif Packet.getType(i) == @@greaterNum
        sps << GreaterPacket.new(i)
      elsif Packet.getType(i) == @@lessNum
        sps << LessPacket.new(i)
      elsif Packet.getType(i) == @@equalNum
        sps << EqualPacket.new(i)
      end
    end
    return sps
  end
  
  def self.getType(bin)
    return binToTen(bin.slice(@@typeStart, @@typeLen))
  end
  
  def self.binToTen(bin)
    i = bin.length
    return bin.split("").inject(0) { |sum, val| sum + (val.to_i * 2 ** (i -= 1)) }
  end
  
  def self.hexToBin(hex)
    hexMap = {
      "0" => "0000",
      "1" => "0001",
      "2" => "0010",
      "3" => "0011",
      "4" => "0100",
      "5" => "0101",
      "6" => "0110",
      "7" => "0111",
      "8" => "1000",
      "9" => "1001",
      "A" => "1010",
      "B" => "1011",
      "C" => "1100",
      "D" => "1101",
      "E" => "1110",
      "F" => "1111",
    }
    return hex.split("").map { |i| hexMap[i] }.join
  end
end

class SumPacket < Packet
  
  def getValue
    return @subPackets.map { |i| i.getValue }.sum
  end
  
end

class ProductPacket < Packet
  
  def getValue
    return @subPackets.inject(1) { |prod, i| prod * i.getValue }
  end
  
end

class MinPacket < Packet
  
  def getValue
    return @subPackets.map { |i| i.getValue }.min
  end
  
end

class MaxPacket < Packet
  
  def getValue
    return @subPackets.map { |i| i.getValue }.max
  end
  
end

class LiteralPacket < Packet
  
  def getValue
    i = @@literalPrefixLen
    binStr = ""
    while @binary.slice(i) == "1"
      binStr += @binary.slice(i + @@literalPrefixSize, @@literalGroupSize)
      i += @@literalTotalGroupSize
    end
    binStr += @binary.slice(i + @@literalPrefixSize, @@literalGroupSize)
    return Packet.binToTen(binStr)
  end
  
  def processSubPackets
    return []
  end
  
  def getVersionSum
    return @version
  end
  
end

class LessPacket < Packet
  
  def getValue
    return (@subPackets[0].getValue < @subPackets[1].getValue) ? 1 : 0
  end
  
end

class GreaterPacket < Packet
  
  def getValue
    return (@subPackets[0].getValue > @subPackets[1].getValue) ? 1 : 0
  end
  
end

class EqualPacket < Packet
  
  def getValue
    return (@subPackets[0].getValue == @subPackets[1].getValue) ? 1 : 0
  end
  
end

