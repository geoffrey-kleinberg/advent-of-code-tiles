class String
  def is_number?
    nums = %w(0 1 2 3 4 5 6 7 8 9)
    sArr = self.split("")
    if sArr[0] == "-"
      sArr = sArr.slice(1, sArr.length - 1)
    end
    return sArr.all? { |i| nums.include? i }
  end
end

input = ''
File.open("input.txt") do |f|
  f.each do |i|
    input = i
  end
end


def part1(input)
  nums = %w(0 1 2 3 4 5 6 7 8 9)
  sum = 0
  curSum = 0
  negative = false
  for i in input.split("")
    if nums.include? i
      curSum *= 10
      curSum += i.to_i
    else
      if i == "-"
        negative = true
      else
        (negative) ? (sum -= curSum) : (sum += curSum)
        curSum = 0
        negative = false
      end
    end
  end
  return sum
end

def makeObj(input)
  firstChar = input.slice(0)
  if firstChar != "{"
    raise "something wrong"
  end
  hash = {}
  openS = 0
  openB = 0
  currKey = ""
  currElement = ""
  currIsArr = nil
  for i in 1...(input.length - 1)
    if input.slice(i) == "["
      openS += 1
    elsif input.slice(i) == "]"
      openS -= 1
    elsif input.slice(i) == "{"
      openB += 1
    elsif input.slice(i) == "}"
      openB -= 1
    end
    
    if openS == 0 and openB == 0 and input.slice(i) == ","
      hash[currKey] = currElement
      currElement = ""
    end
    
    if openS == 0 and openB == 0 and input.slice(i) == ":"
      currKey = currElement
      currElement = ""
    end
    
    if openS != 0 or openB != 0 or (input.slice(i) != "," and input.slice(i) != ":")
      currElement += input.slice(i)
    end
    
  end
  
  hash[currKey] = currElement
  
  for i in hash.keys
    if hash[i].slice(0) == "{"
      hash[i] = makeObj(hash[i])
    elsif hash[i].slice(0) == "["
      hash[i] = makeArr(hash[i])
    end
  end
  
  return hash
end

def makeArr(input)
  firstChar = input.slice(0)
  if firstChar != "["
    raise "something wrong"
  end
  arr = []
  openS = 0
  openB = 0
  currElement = ""
  currIsArr = nil
  for i in 1...(input.length - 1)
    if input.slice(i) == "["
      openS += 1
    elsif input.slice(i) == "]"
      openS -= 1
    elsif input.slice(i) == "{"
      openB += 1
    elsif input.slice(i) == "}"
      openB -= 1
    end
    
    if openS == 0 and openB == 0 and input.slice(i) == ","
      arr.append(currElement)
      currElement = ""
    end
    
    if openS != 0 or openB != 0 or input.slice(i) != ","
      currElement += input.slice(i)
    end
    
  end
  
  arr << currElement
  
  formArr = []
  for i in arr
    if i.slice(0) == "["
      formArr << makeArr(i)
    elsif i.slice(0) == "{"
      formArr << makeObj(i)
    else
      formArr << i
    end
  end
  
  return formArr
end

def getArrSum(arr)
  sum = 0
  for i in arr
    if i.is_a? Array
      sum += getArrSum(i)
    elsif i.is_a? Hash
      sum += getObjSum(i)
    else
      sum += i.to_i
    end
  end
  return sum
end

def getObjSum(object)
  if object.values.include? "\"red\""
    return 0
  else
    sum = 0
    for i in object.keys
      if i.is_number?
        sum += i.to_i
      end
      val = object[i]
      if val.is_a? Array
        sum += getArrSum(val)
      elsif val.is_a? Hash
        sum += getObjSum(val)
      else
        sum += val.to_i
      end
    end
    return sum
  end
end

def part2(input)
  object = makeArr(input)
  print object
  puts
  sum = getArrSum(object)
  return sum
end


#input = '[1,"red",5]'

#puts part1(input)
puts part2(input)