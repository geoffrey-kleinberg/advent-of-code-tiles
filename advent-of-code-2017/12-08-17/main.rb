require 'set'

day = "08"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    reg = {}
    reg.default = 0
    for line in input
      parts = line.split(" ")
      comp = parts[5]
      comp1 = parts[4]
      comp2 = parts[6]
      doOp = false
      if comp == ">"
        if reg[comp1] > comp2.to_i
          doOp = true
        end
      elsif comp == "<"
        if reg[comp1] < comp2.to_i
          doOp = true
        end
      elsif comp == "=="
        if reg[comp1] == comp2.to_i
          doOp = true
        end
      elsif comp == "!="
        if reg[comp1] != comp2.to_i
          doOp = true
        end
      elsif comp == ">="
        if reg[comp1] >= comp2.to_i
          doOp = true
        end
      elsif comp == "<="
        if reg[comp1] <= comp2.to_i
         doOp = true
        end
      end

      if doOp
        op = parts[1]
        if op == "inc"
        
          reg[parts[0]] += parts[2].to_i
        elsif op == "dec"
          reg[parts[0]] -= parts[2].to_i
        end
      end
    end

    return reg.values.max
end

def part2(input)
    reg = {}
    reg.default = 0

    max = -1 * Float::INFINITY
    for line in input
      parts = line.split(" ")
      comp = parts[5]
      comp1 = parts[4]
      comp2 = parts[6]
      doOp = false
      if comp == ">"
        if reg[comp1] > comp2.to_i
          doOp = true
        end
      elsif comp == "<"
        if reg[comp1] < comp2.to_i
          doOp = true
        end
      elsif comp == "=="
        if reg[comp1] == comp2.to_i
          doOp = true
        end
      elsif comp == "!="
        if reg[comp1] != comp2.to_i
          doOp = true
        end
      elsif comp == ">="
        if reg[comp1] >= comp2.to_i
          doOp = true
        end
      elsif comp == "<="
        if reg[comp1] <= comp2.to_i
         doOp = true
        end
      end

      if doOp
        op = parts[1]
        if op == "inc"
        
          reg[parts[0]] += parts[2].to_i
          if reg[parts[0]] > max
            max = reg[parts[0]]
          end
        elsif op == "dec"
          reg[parts[0]] -= parts[2].to_i
          if reg[parts[0]] > max
            max = reg[parts[0]]
          end
        end
      end
    end

    return max
end

puts part1(data)
puts part2(data)