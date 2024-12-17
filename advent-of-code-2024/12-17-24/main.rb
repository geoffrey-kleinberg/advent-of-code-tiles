require 'set'

day = "17"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

# 163656517 wrong
# should be 9 digits

def part1(input)

    # register = {
    #     "A" => 30899381,
    #     "B" => 0,
    #     "C" => 0
    # }

    # register["A"] = 0
    # register["B"] = 2024
    # register["C"] = 43690

    # combo = {
    #     4 => "A",
    #     5 => "B",
    #     6 => "C"
    # }

    # out = []

    # program = input[0].split(",").map { |i| i.to_i }
    # inst = 0
    # while inst < program.length
    #   opcode = program[inst]
    #   operand = program[inst + 1]
    #   if opcode == 0
    #     numerator = register["A"]
    #     if operand >= 4
    #       operand = register[combo[operand]]
    #     end
    #     operand = 2 ** operand

    #     register["A"] = numerator / operand

    #     inst += 2
    #   end
    #   if opcode == 1
    #     register["B"] = register["B"] ^ operand
    #     inst += 2
    #   end
    #   if opcode == 2
    #     if operand >= 4
    #       operand = register[combo[operand]]
    #     end
    #     register["B"] = operand % 8
    #     inst += 2
    #   end
    #   if opcode == 3
    #     if register["A"] == 0
    #       inst += 2
    #     else
    #       inst = operand
    #     end
    #   end
    #   if opcode == 4
    #     register["B"] = register["B"] ^ register["C"]
    #     inst += 2
    #   end
    #   if opcode == 5
    #     if operand >= 4
    #       operand = register[combo[operand]]
    #     end
    #     out.append(operand % 8)
    #     inst += 2
    #   end
    #   if opcode == 6
    #     numerator = register["A"]
    #     if operand >= 4
    #       operand = register[combo[operand]]
    #     end
    #     operand = 2 ** operand

    #     register["B"] = numerator / operand

    #     inst += 2
    #   end
    #   if opcode == 7
    #     numerator = register["A"]
    #     if operand >= 4
    #       operand = register[combo[operand]]
    #     end
    #     operand = 2 ** operand

    #     register["C"] = numerator / operand

    #     inst += 2
    #   end
    # end

    # print register
    # puts
    # return out.join
    # 
    #
    out = []
    a = 6050770682
    a = 3622 * 8 + 7
    b = 0
    c = 0
    while a > 0
      puts a
      b = a % 8
      b = b ^ 1
      c = a / (2 ** b)
      b = b ^ c
      a = a / 8
      b = b ^ 6
      out.append(b % 8)
    end
    return out.join(",")
end

def iter(a)
    b = a % 8
    b = b ^ 1
    c = a / (2 ** b)
    b = b ^ c
    a = a / 8
    b = b ^ 6
    return b % 8
end

def part2(input)

    outs = input[0].split(",").map { |i| i.to_i }
    possible = [0]
    for loc in 0...outs.length
      goal = outs[outs.length - loc - 1]
      nextPossible = []
      for p in possible
        for add in 0..7
            if iter((p * 8) + add) == goal
                nextPossible.append((p * 8) + add)
            end
        end
      end
      possible = nextPossible
    end
    return possible.min
end

# puts part1(data)
puts part2(data)