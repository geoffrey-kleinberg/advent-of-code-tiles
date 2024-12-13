input = []
File.open("input.txt") do |f|
	f.each do |i|
		input << i.to_i
	end
end
def part1(input)
  result = 0
  
  last = input[0]
  for i in input.slice(1, input.length - 1)
    if i > last
      result += 1
    end
    last = i
    
  end
  return result
  
end
def part2(input)
  result = 0
  
  three = input[0]
  two = input[1]
  one = input[2]
  for i in input.slice(3, input.length - 1)
    if i + two + one > three + two + one
      result += 1
    end
    three = two
    two = one
    one = i
    
  end
  return result
  
end
puts part2(input)