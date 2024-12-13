day = "06"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    result = ""
    rotated = input.map { |i| i.split("") }.transpose
    for line in rotated
        counts = {}
        for letter in line
            if not counts[letter]
                counts[letter] = 0
            end
            counts[letter] += 1
        end
        result += counts.keys.max { |i, j| counts[i] <=> counts[j] }
    end
    return result
end

def part2(input)
    result = ""
    rotated = input.map { |i| i.split("") }.transpose
    for line in rotated
        counts = {}
        for letter in line
            if not counts[letter]
                counts[letter] = 0
            end
            counts[letter] += 1
        end
        result += counts.keys.min { |i, j| counts[i] <=> counts[j] }
    end
    return result
end

puts part1(data)
puts part2(data)