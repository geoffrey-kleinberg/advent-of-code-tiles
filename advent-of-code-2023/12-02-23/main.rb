file_name = '12-02-23/sampleIn.txt'
file_name = '12-02-23/input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    sum = 0
    for game_num in 1..(input.length)
        valid = true
        game = input[game_num - 1]
        draws = game.split(": ")[1].split("; ")
        for draw in draws
            colors = draw.split(", ")
            for c in colors
                num, color = c.split(" ")
                if color == "red" and num.to_i > 12
                    valid = false
                end
                if color == "green" and num.to_i > 13
                    valid = false
                end
                if color == "blue" and num.to_i > 14
                    valid = false
                end
            end
        end
        if valid
            sum += game_num
        end
    end
    return sum
end

def part2(input)
    sum = 0
    for game_num in 1..(input.length)
        minRed = -1 * Float::INFINITY
        minGreen = -1 *Float::INFINITY
        minBlue = -1 *Float::INFINITY
        game = input[game_num - 1]
        draws = game.split(": ")[1].split("; ")
        for draw in draws
            colors = draw.split(", ")
            for c in colors
                num, color = c.split(" ")
                if color == "red" and num.to_i > minRed
                    minRed = num.to_i
                end
                if color == "green" and num.to_i > minGreen
                    minGreen = num.to_i
                end
                if color == "blue" and num.to_i > minBlue
                    minBlue = num.to_i
                end
            end
        end
        power = minRed * minBlue * minGreen
        sum += power
    end
    return sum
end

puts part1(data)
puts part2(data)