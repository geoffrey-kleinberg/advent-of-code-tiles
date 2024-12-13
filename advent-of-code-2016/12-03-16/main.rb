day = "03"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def isTriangle(sides)
    sums = [sides[1] + sides[2], sides[0] + sides[2], sides[0] + sides[1]]
    valid = true
    for s in 0...3
        if sides[s] >= sums[s]
            valid = false
        end
    end
    return valid
end

def part1(input)
    count = 0
    for line in input
        sides = line.split(" ").map { |j| j.to_i }
        count += 1 if isTriangle(sides)
    end       
    return count
end

def part2(input)
    data = input.map { |i| i.split(" ").map { |j| j.to_i }}
    data = data.transpose
    count = 0
    for l in data
        while l.length > 0
            sides = l.take(3)
            count += 1 if isTriangle(sides)
            l.shift(3)
        end
    end
    return count
end

puts part1(data)
puts part2(data)