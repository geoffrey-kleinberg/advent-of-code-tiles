require 'set'

day = "19"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def isPossible(towel, available, memo)

  if memo[towel]
    return (memo[towel] == 1) ? true : false
  end

  if available.include? towel
    memo[towel] = 1
    return true
  end
  
  for a in available
    l = a.length
    if towel.slice(0, l) == a
      nextCheck = towel[l..]
      if isPossible(nextCheck, available, memo)
        memo[towel] = 1
        return true
      end
    end
  end
  memo[towel] = false
  return false

end

def part1(input)
    available = input[0].split(', ')

    memo = {}

    possible = 0
    for line in input[2..]
      if isPossible(line, available, memo)
        possible += 1
      end
    end
    return possible
end

def countWays(towel, available, memo)

    if memo[towel]
      return memo[towel]
    end


    total = 0
    
    for a in available
      l = a.length
      next if l > towel.length
      if a == towel
        total += 1
      elsif towel.slice(0, l) == a
        nextCheck = towel[l..]
        c = countWays(nextCheck, available, memo)
        total += c
      end
    end

    memo[towel] = total
    return total
  
end

def part2(input)
    available = input[0].split(', ')

    memo = {}

    possible = 0
    for line in input[2..]
      c = countWays(line, available, memo)
      possible += c
    end
    return possible
end

# puts part1(data)
puts part2(data)