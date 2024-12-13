require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def snafuToTen(num, digits)
  total = 0
  for i in 0...num.length
    power = num.length - i - 1
    total += digits[num[i]] * (5 ** power)
  end
  return total
end

def tenToSnafu(num, digits)
  snafu = ""
  digit = 1
  while num > 0
    nextDig = num % (5 ** digit)
    if nextDig == 4
      nextDig = -1
      num += (5 ** (digit - 1))
    elsif nextDig == 3
      nextDig = -2
      num += 2 * (5 ** (digit - 1))
    end
    #puts num
    #puts nextDig
    num /= 5
    snafu = digits[nextDig] + snafu
  end
  return snafu
end

def part1(input)
  digits = { -2 => "=", -1 => "-", 0 => "0", 1 => "1", 2 => "2" }
  revDigits = {
    "=" => -2,
    "-" => -1,
    "0" => 0,
    "1" => 1,
    "2" => 2
  }
  sum = 0
  for i in input
    sum += snafuToTen(i.split(""), revDigits)
    #puts snafuToTen(i.split(""), revDigits)
  end
  
  return tenToSnafu(sum, digits)
  
end

puts part1(data)