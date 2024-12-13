require 'set'

day = "23"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  vals = {
    'a' => 7,
    'b' => 0,
    'c' => 0,
    'd' => 0
  }
  line = 0
  while line < input.length
    inst = input[line].split(" ")
    if inst[0] == 'cpy'
      if vals.keys.include? inst[1]
        vals[inst[2]] = vals[inst[1]]
      else
        vals[inst[2]] = inst[1].to_i
      end
      line += 1
    end
    if inst[0] == 'inc'
      if vals.keys.include? inst[1]
        vals[inst[1]] += 1
      end
      line += 1
    end
    if inst[0] == 'dec'
      if vals.keys.include? inst[1]
        vals[inst[1]] -= 1
      end
      line += 1
    end
    if inst[0] == 'jnz'
      if vals[inst[1]] != 0
        if vals.keys.include? inst[2]
          line += vals[inst[2]]
        else
          line += inst[2].to_i
        end
      else
        line += 1
      end
    end
    if inst[0] == 'tgl'
      targetDist = vals[inst[1]]
      targetLine = input[line + targetDist]
      if targetLine
        targetLine = targetLine.split(" ")
      else
        line += 1
        next
      end
      if targetLine.length == 2
        if targetLine[0] == "inc"
          targetLine[0] = "dec"
        else
          targetLine[0] = "inc"
        end
        input[line + targetDist] = targetLine.join(" ")
      elsif targetLine.length == 3
        if targetLine[0] == "jnz"
          targetLine[0] = "cpy"
        else
          targetLine[0] = "jnz"
        end
        input[line + targetDist] = targetLine.join(" ")
      end
      line += 1
    end
    # puts inst.join(" ")
    # print vals
    # puts
  end
  print vals
  puts
  return vals['a']
end

def factorial(n)
  return (1..n).inject(1) { |prod, i| prod * i}
end

def part2(input)
  # reading assembunny, the result is factorial(a) + 84 * 80 for a >= 6
  a = 12
  return factorial(a) + 84 * 80
end

# puts part1(data)
puts part2(data)