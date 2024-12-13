day = "05"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    rules = {}
    manuals = []
    rule = true
    for i in 0...input.length
      if input[i] == ''
        rule = false
        next
      end
      if rule
        a, b = input[i].split('|')
        if rules[a]
          rules[a].append(b)
        else
          rules[a] = [b]
        end
      else
        nums = input[i].split(',')
        manuals.append(nums)
      end
    end

    good_manuals = []
    for m in manuals
      valid = true
      for idx in 0...manuals.length
        break if not valid
        check = m[manuals.length - 1 - idx]
        if not rules[check]
          next
        end
        for j in 0...(manuals.length - 1 - idx)
          if rules[check].include? m[j]
            valid = false
            break
          end
        end
      end
      if valid
        good_manuals.append(m)
      end
    end
    sum = 0
    for i in good_manuals
      sum += i[(i.length - 1) / 2].to_i
    end
    return sum
end

def part2(input)
    rules = {}
    manuals = []
    rule = true
    for i in 0...input.length
      if input[i] == ''
        rule = false
        next
      end
      if rule
        a, b = input[i].split('|')
        if rules[a]
          rules[a].append(b)
        else
          rules[a] = [b]
        end
      else
        nums = input[i].split(',')
        manuals.append(nums)
      end
    end
    bad_manuals = []
    for m in manuals
      valid = true
      for idx in 0...manuals.length
        break if not valid
        check = m[manuals.length - 1 - idx]
        if not rules[check]
          next
        end
        for j in 0...(manuals.length - 1 - idx)
          if rules[check].include? m[j]
            valid = false
            break
          end
        end
      end
      if not valid
        bad_manuals.append(m)
      end
    end

    sum = 0
    for i in bad_manuals
        befores = {}
        for j in i
            if rules[j]
                befores[j] = rules[j].count { |id| i.include? id }
            else
                befores[j] = 0
            end
        end
        
        for j in i
          if befores[j] == (i.length - 1) / 2
            sum += j.to_i
            break
          end
        end
    end
    return sum
end

# puts part1(data)
puts part2(data)