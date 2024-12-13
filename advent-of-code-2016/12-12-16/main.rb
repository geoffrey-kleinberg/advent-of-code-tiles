require 'set'

day = "12"
file_name = "12-#{day}-16/sampleIn.txt"
# file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

# 9227731 too high

def part1(input)
  vals = {
    'a' => 0,
    'b' => 0,
    'c' => 1,
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
      vals[inst[1]] += 1
      line += 1
    end
    if inst[0] == 'dec'
      vals[inst[1]] -= 1
      line += 1
    end
    if inst[0] == 'jnz'
      if vals[inst[1]] != 0
        line += inst[2].to_i
      else
        line += 1
      end
    end
  end
  return vals['a']
end

def part2(input)
  return input
end

puts part1(data)
# puts part2(data)