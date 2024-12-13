day = "07"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def to_base_b_string(num, b, l)
  str = num.to_s(b)
  while str.length < l
    str = '0' + str
  end
  return str
end

def canMatchP1(goal, start, remaining)
  if remaining.length == 1
    if (start + remaining[0] == goal) or (start * remaining[0] == goal)
      return true
    else
      return false
    end
  end
  first = remaining[0]
  left = remaining[1..-1]
  if canMatchP1(goal, start + first, left) or canMatchP1(goal, start * first, left)
    return true
  else
    return false
  end
end

def recursivep1(input)
  sum = 0
  for line in input
    goal, nums = line.split(": ")
    nums = nums.split(" ").map { |i| i.to_i }
    goal = goal.to_i
    if canMatchP1(goal, nums[0], nums[1..-1])
      sum += goal
    end
  end
  return sum
end

def part1(input)
    sum = 0
    for line in input
      goal, nums = line.split(": ")
      nums = nums.split(" ").map { |i| i.to_i }
      goal = goal.to_i
    #   puts goal
      for o in 0...(2 ** (nums.length - 1))
        ops = to_base_b_string(o, 2, (nums.length - 1)).split("")
        val = nums[0]
        for i in 1...nums.length
          if ops[i - 1] == "1"
            val += nums[i]
          else
            val *= nums[i]
          end
        end
        # puts val
        if val == goal
          sum += goal
          break
        end
      end
    #   puts
    end
    return sum
end

def canMatchP2(goal, start, remaining)
  if remaining.length == 1
    if (start + remaining[0] == goal) or (start * remaining[0] == goal) or ((start.to_s + remaining[0].to_s).to_i == goal)
      return true
    else
      return false
    end
  end
  first = remaining[0]
  left = remaining[1..-1]
  if canMatchP2(goal, start + first, left) or canMatchP2(goal, start * first, left) or canMatchP2(goal, (start.to_s + first.to_s).to_i, left)
    return true
  else
    return false
  end
end

def recursivep2(input)
  sum = 0
  for line in input
    goal, nums = line.split(": ")
    nums = nums.split(" ").map { |i| i.to_i }
    goal = goal.to_i
    if canMatchP2(goal, nums[0], nums[1..-1])
      sum += goal
    end
  end
  return sum
end

def part2(input)
    sum = 0
    for line in input
      goal, nums = line.split(": ")
      nums = nums.split(" ").map { |i| i.to_i }
      goal = goal.to_i
      puts goal
    #   puts goal
      for o in 0...(3 ** (nums.length - 1))
        ops = to_base_b_string(o, 3, (nums.length - 1)).split("")
        val = nums[0]
        for i in 1...nums.length
          if ops[i - 1] == "2"
            val += nums[i]
          elsif ops[i - 1] == "1"
            val *= nums[i]
          else
            val = (val.to_s + nums[i].to_s).to_i
          end
        end
        # puts val
        if val == goal
          sum += goal
          break
        end
      end
    #   puts
    end
    return sum
end

# t = Time.now
# puts part1(data)
# puts Time.now - t # --> 0.871
# t = Time.now
puts recursivep1(data)
# puts Time.now - t # --> 0.075

# t = Time.now
# puts part2(data)
# puts Time.now - t # 98.324
# t = Time.now
puts recursivep2(data)
# puts Time.now - t # 4.782