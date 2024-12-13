def getTriNum(n)
  return n * (n + 1) / 2
end

def getNum(row, col)
  startNum = 1 - row
  return startNum + getTriNum(col + row - 1)
end

def main(row, col)
  code = 20151125
  for i in 1...getNum(row, col)
    code *= 252533
    code %= 33554393
  end
  return code
end

puts main(4, 4)
puts main(3010, 3019)