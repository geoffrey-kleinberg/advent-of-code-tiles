require 'set'

day = "09"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    spl = input[0].split("")
    total = 0
    curNest = 1
    inGarbage = false
    index = 1
    while curNest > 0
        char = spl[index]
        if char == "{" and not inGarbage
          curNest += 1

        end
        if char == "}" and not inGarbage
          total += curNest
          curNest -= 1
        end
        if char == "<"
          inGarbage = true
        end
        if char == ">"
          inGarbage = false
        end

        if char == "!"
          index += 1
        end

        index += 1
    end

    puts index == spl.length
    return total
end

def part2(input)
    spl = input[0].split("")
    total = 0
    curNest = 1
    inGarbage = false
    garbageChars = 0
    index = 1
    while curNest > 0
        char = spl[index]
        if inGarbage
          garbageChars += 1
        end
        if char == "{" and not inGarbage
          curNest += 1

        end
        if char == "}" and not inGarbage
          total += curNest
          curNest -= 1
        end
        if char == "<"
          inGarbage = true
        end
        if char == ">"
          inGarbage = false
          garbageChars -= 1
        end

        if char == "!"
          garbageChars -= 1
          index += 1
        end

        index += 1
    end

    return garbageChars
end

# puts part1(data)
puts part2(data)