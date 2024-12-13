day = "02"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    grid = {
        "1" => Hash["D", "4", "R", "2"],
        "2" => Hash["D", "5", "R", "3", "L", "1"],
        "3" => Hash["D", "6", "L", "2"],
        "4" => Hash["U", "1", "R", "5", "D", "7"],
        "5" => Hash["U", "2", "D", "8", "R", "6", "L", "4"],
        "6" => Hash["U", "3", "D", "9", "L", "5"],
        "7" => Hash["U", "4", "R", "8"],
        "8" => Hash["L", "7", "U", "5", "R", "9"],
        "9" => Hash["L", "8", "U", "6"]
    }
    str = ""
    current = "5"
    for l in input
        curLine = l.split("")
        for i in curLine
            if grid[current][i]
                current = grid[current][i]
            end
        end
        str += current
    end
    return str
end

def part2(input)
    grid = {
        "1" => Hash["D", "3"],
        "2" => Hash["D", "6", "R", "3"],
        "3" => Hash["D", "7", "L", "2", "U", "1", "R", "4"],
        "4" => Hash["L", "3", "D", "8"],
        "5" => Hash["R", "6"],
        "6" => Hash["U", "2", "D", "A", "L", "5", "R", "7"],
        "7" => Hash["U", "3", "R", "8", "L", "6", "D", "B"],
        "8" => Hash["L", "7", "U", "4", "R", "9", "D", "C"],
        "9" => Hash["L", "8"],
        "A" => Hash["R", "B", "U", "6"],
        "B" => Hash["U", "7", "R", "C", "L", "A", "D", "D"],
        "C" => Hash["U", "8", "L", "B"],
        "D" => Hash["U", "B"]
    }
    str = ""
    current = "5"
    for l in input
        curLine = l.split("")
        for i in curLine
            if grid[current][i]
                current = grid[current][i]
            end
        end
        str += current
    end
    return str
end

# puts part1(data)
puts part2(data)