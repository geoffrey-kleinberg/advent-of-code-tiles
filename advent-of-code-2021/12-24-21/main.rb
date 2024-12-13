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

def oneInput(x, y, z, w, add1, divide, add2)
  x = z % 26 + add1
  z = (z / divide.to_f).truncate
  (x == w) ? (x = 0) : (x = 1)
  y = 25 * x + 1
  z *= y
  y = (w + add2) * x
  z += y
  return [x, y, z]
end

def calcZ(num)
  x, y, z = 0, 0, 0
  add1s = {
    0 => 12,
    1 => 10,
    2 => 10,
    3 => -6,
    4 => 11,
    5 => -12,
    6 => 11,
    7 => 12,
    8 => 12,
    9 => -2,
    10 => -5,
    11 => -4,
    12 => -4,
    13 => -12 
  }
  mults = {
    0 => 1,
    1 => 1,
    2 => 1,
    3 => 26,
    4 => 1,
    5 => 26,
    6 => 1,
    7 => 1,
    8 => 1,
    9 => 26,
    10 => 26,
    11 => 26,
    12 => 26,
    13 => 26
  }
  add2s = {
    0 => 6,
    1 => 2,
    2 => 13,
    3 => 8,
    4 => 13,
    5 => 8,
    6 => 3,
    7 => 11,
    8 => 10,
    9 => 8,
    10 => 14,
    11 => 6,
    12 => 8,
    13 => 2
  }
  for i in 0...num.length
    w = num.slice(i).to_i
    x, y, z = oneInput(x, y, z, w, add1s[i], mults[i], add2s[i])
  end
  return x, z
end


class Calc
  @@known = {}
  
  def self.getNext(num)
    if @@known[num] != nil
      return @@known[num]
    end
    found = false
    for i in 1..9
      if calcZ(num + i.to_s)[0] == 0
        raise "ahhhh" if found
        found = true
        @@known[num] = i.to_s
      end
    end
    if not @@known[num]
      @@known[num] = false
    end
    return @@known[num]
  end

end

def minus(baseNum)
  baseNum = baseNum.to_i - 1
  while baseNum.to_s.include? "0"
    baseNum -= 1
  end
  baseNum = baseNum.to_s
  return baseNum
end

def testNum(baseNum)
  num = baseNum.slice(0, 3)
  #puts baseNum
  digit4 = Calc.getNext(num)
  return false if not digit4
  num += digit4 + baseNum.slice(3)
  digit6 = Calc.getNext(num)
  return false if not digit6
  num += digit6 + baseNum.slice(4, 3)
  digit10 = Calc.getNext(num)
  return false if not digit10
  num += digit10
  digit11 = Calc.getNext(num)
  return false if not digit11
  num += digit11
  digit12 = Calc.getNext(num)
  return false if not digit12
  num += digit12
  digit13 = Calc.getNext(num)
  return false if not digit13
  num += digit13
  digit14 = Calc.getNext(num)
  return false if not digit14
  num += digit14
  return num
end

def part1
  tested = 0
  t = Time.now
  baseNum = "9999999"
  loop do
    tested += 1
    break if baseNum.to_i < 1000000
    if (a = testNum(baseNum))
      puts (Time.now - t) / tested
      return a
    end
    baseNum = minus(baseNum)
  end
  return "not found"
end

def up(baseNum)
  baseNum = baseNum.to_i + 1
  while baseNum.to_s.include? "0"
    baseNum += 1
  end
  baseNum = baseNum.to_s
  return baseNum
end

def part2
  tested = 0
  t = Time.now
  baseNum = "1111111"
  loop do
    tested += 1
    break if baseNum.to_i > 10000000
    if (a = testNum(baseNum))
      puts (Time.now - t) / tested
      return a
    end
    baseNum = up(baseNum)
  end
  return "not found"
end

puts part1

puts

puts part2