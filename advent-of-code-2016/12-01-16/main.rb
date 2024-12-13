require 'set'

file_name = 'sampleIn.txt'
file_name = 'input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    steps = input[0].split(", ")
    facing = 0
    location = [0, 0]
    for step in steps
        if step.slice(0) == 'R'
            facing += 1
        else
            facing -= 1
        end
        facing %= 4
        distance = step[1..-1].to_i
        if facing == 0
            location[1] += distance
        elsif facing == 1
            location[0] += distance
        elsif facing == 2
            location[1] -= distance
        elsif facing == 3
            location[0] -= distance
        else
            raise "error"
        end
    end
    return location.map { |i| i.abs }.sum
end

def part2(input)
    steps = input[0].split(", ")
    facing = 0
    location = [0, 0]
    locations = Set[location]
    for step in steps
        if step.slice(0) == 'R'
            facing += 1
        else
            facing -= 1
        end
        facing %= 4
        distance = step[1..-1].to_i
        for i in 0...distance
            if facing == 0
                location[1] += 1
            elsif facing == 1
                location[0] += 1
            elsif facing == 2
                location[1] -= 1
            elsif facing == 3
                location[0] -= 1
            end
            if not locations.add? location.clone
                return location.map { |i| i.abs }.sum
            end
        end
    end
    return 0
end

# puts part1(data)
puts part2(data)