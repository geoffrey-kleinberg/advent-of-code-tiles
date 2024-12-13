fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def containsDup(len3)
  return (len3.slice(0) == len3.slice(1) or len3.slice(0) == len3.slice(2) or len3.slice(1) == len3.slice(2))
end

def part1(input)
  lastThree = input[0].slice(0, 3)
  for i in 3...input[0].length
    nextChar = input[0].slice(i)
    if not lastThree.include? nextChar and not containsDup(lastThree)
      return i + 1
    else
      lastThree = lastThree.slice(1, 2) + nextChar
    end
  end
end

def containsDup2(str)
  for i in str.split("")
    if str.count(i) > 1
      return true
    end
  end
  return false
end

def part2(input)
  lastThirteen = input[0].slice(0, 13)
  for i in 13...input[0].length
    nextChar = input[0].slice(i)
    if not lastThirteen.include? nextChar and not containsDup2(lastThirteen)
      return i + 1
    else
      lastThirteen = lastThirteen.slice(1, 12) + nextChar
    end
  end
end

puts part1(data)
puts part2(data)