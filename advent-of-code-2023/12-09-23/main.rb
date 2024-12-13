day = "09"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    sum = 0
    for line in input
        line = line.split(" ").map { |i| i.to_i }
        sequences = [line]
        while not line.all? { |i| i == 0}
            next_line = []
            for i in 0...(line.length - 1)
                next_line.append(line[i + 1] - line[i])
            end
            line = next_line.clone
            sequences << line
        end
        value = 0
        for seq in sequences.reverse
            value += seq.slice(-1)
        end
        sum += value
    end
    return sum
end

def part2(input)
    sum = 0
    for line in input
        line = line.split(" ").map { |i| i.to_i }
        sequences = [line]
        while not line.all? { |i| i == 0}
            next_line = []
            for i in 0...(line.length - 1)
                next_line.append(line[i + 1] - line[i])
            end
            line = next_line.clone
            sequences << line
        end
        value = 0
        #print
        for seq in sequences.reverse
            value = seq[0] - value
        end
        sum += value
    end
    return sum
end

# puts part1(data)
puts part2(data)