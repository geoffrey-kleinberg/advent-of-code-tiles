day = '06'
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    times = input[0].split(": ")[1].split(" ").map { |i| i.to_i }
    distances = input[1].split(": ")[1].split(" ").map { |i| i.to_i }
    prod = 1
    for i in 0...times.length
        time = times[i]
        distance = distances[i]
        cnt = 0
        for j in 0..time
            if j * (time - j) > distance
                cnt += 1
            end
        end
        prod *= cnt
    end
    return prod
end

def part2(input)
    time = input[0].split(": ")[1].split(" ").join.to_i
    distance = input[1].split(": ")[1].split(" ").join.to_i
    first = ((time - Math.sqrt(time ** 2 - 4 * distance)) / 2).ceil
    last = ((time + Math.sqrt(time ** 2 - 4 * distance)) / 2).floor
    return last - first + 1
end

# puts part1(data)
puts part2(data)