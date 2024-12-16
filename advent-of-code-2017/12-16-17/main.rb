require 'set'

day = "16"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

# fgcmjbidnpaoehkl is wrong

def part1(input)
    letters = ('a'..'p').to_a

    for inst in input[0].split(",")
        if inst[0] == "s"
            d = inst[1..].to_i
            letters = letters.rotate(-1 * d)
        elsif inst[0] == "p"
            l1, l2 = inst[1..].split('/')
            i1 = letters.index(l1)
            i2 = letters.index(l2)
            letters[i1] = l2
            letters[i2] = l1
        elsif inst[0] == "x"  
            i1, i2 = inst[1..].split('/').map { |i| i.to_i }
            letters[i1], letters[i2] = letters[i2], letters[i1]
        end 
    end

    return letters.join
end

def part2(input)
    indices = {}

    index = 0

    letters = ('a'..'p').to_a

    splitInst = input[0].split(",")

    totalIters = 1000000000 * splitInst.length

    1000000000.times do
        instInd = 0
        for inst in splitInst
            prev = indices[[letters.join, instInd]]
            if prev
              offset = prev
              mod = (index - prev)
              offset2 = (totalIters - offset) % mod
              for k in indices.keys
                if indices[k] == offset + offset2
                  return k[0]
                end
              end
            end
            indices[[letters.join, instInd]] = index
            if inst[0] == "s"
                d = inst[1..].to_i
                letters = letters.rotate(-1 * d)
            elsif inst[0] == "p"
                l1, l2 = inst[1..].split('/')
                i1 = letters.index(l1)
                i2 = letters.index(l2)
                letters[i1] = l2
                letters[i2] = l1
            elsif inst[0] == "x"  
                i1, i2 = inst[1..].split('/').map { |i| i.to_i }
                letters[i1], letters[i2] = letters[i2], letters[i1]
            end 
            index += 1
            instInd += 1
        end
    end

end

puts part1(data)
puts part2(data)