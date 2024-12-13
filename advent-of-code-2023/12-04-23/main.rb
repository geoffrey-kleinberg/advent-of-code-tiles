file_name = '12-04-23/sampleIn.txt'
file_name = '12-04-23/input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    sum = 0
    for card in input
        nums = card.split(": ")[1]
        my_nums = nums.split(" | ")[0].split(" ").map{ |i| i.to_i }
        win_nums = nums.split(" | ")[1].split(" ").map{ |i| i.to_i }
        pow = -1
        for num in my_nums
            if win_nums.include? num
                pow += 1
            end
        end
        sum += (pow < 0) ? 0 : (2 ** pow)
    end
    return sum
end

def part2(input)
    sum = 0
    counts = {}
    i = 1
    for card in input
        counts[i] = (counts[i]) ? (counts[i] + 1) : 1
        nums = card.split(": ")[1]
        my_nums = nums.split(" | ")[0].split(" ").map{ |i| i.to_i }
        win_nums = nums.split(" | ")[1].split(" ").map{ |i| i.to_i }
        matches = 0
        for num in my_nums
            if win_nums.include? num
                matches += 1
            end
        end
        for inc in 1..matches
            counts[i + inc] = (counts[i + inc]) ? (counts[i + inc] + counts[i]) : counts[i]
        end
        sum += counts[i]
        i += 1
    end
    return sum
end

puts part1(data)
puts part2(data)