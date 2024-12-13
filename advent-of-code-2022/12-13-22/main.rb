fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def makeList(line)
  list = []
  theseEls = ""
  depth = 0
  for i in line.split("")
    if i == "["
      if depth != 0
        theseEls += "["
      end
      depth += 1
    elsif i == "]"
      depth -= 1
      if depth != 0
        theseEls += "]"
      end
    elsif i == "," and depth == 1
      if theseEls.slice(0) == "["
        list.append(makeList(theseEls))
      else
        list.append(theseEls.to_i)
      end
      theseEls = ""
    else
      theseEls += i
    end
  end
  if theseEls.slice(0) == "["
    list.append(makeList(theseEls))
  elsif theseEls != ""
    list.append(theseEls.to_i)
  end
  return list
end

def compareInt(left, right)
  if left < right
    return true
  elsif left > right
    return false
  else
    return "next"
  end
end

def compareArr(left, right)
  for i in 0...left.length
    return false if not right[i]
    if left[i].is_a? Integer and right[i].is_a? Integer
      result = compareInt(left[i], right[i])
      next if result == "next"
      return result
    elsif [left[i], right[i]].any? { |j| j.is_a? Integer }
      if left[i].is_a? Integer
        left[i] = [left[i]]
      else
        right[i] = [right[i]]
      end
      result = compareArr(left[i].clone, right[i].clone)
      next if result == "next"
      return result
    else
      result = compareArr(left[i].clone, right[i].clone)
      next if result == "next"
      return result
    end
  end
  if left.length < right.length
    return true
  end
  return "next"
end

#3252 and 4683 are wrong
def part1(input)
  score = 0
  for pair in 0..(input.length / 3)
    left = makeList(input[3 * pair])
    right = makeList(input[3 * pair + 1])
    #print left
    ##puts
    #print right
    #puts
    valid = compareArr(left, right)
    #puts valid
    
    if valid 
      score += pair + 1
    end
  end
  return score
end

def boolToInt(bool)
  if bool
    return -1
  else
    return 1
  end
end

def part2(input)
  input.delete_if { |i| i == "" }
  input.append("[[2]]")
  input.append("[[6]]")
  input = input.map { |i| makeList(i) }
  input = input.sort { |i, j| boolToInt(compareArr(i.clone, j.clone)) }
  return (input.index([[2]]) + 1) * (input.index([[6]]) + 1)
end

puts part1(data)
puts part2(data)