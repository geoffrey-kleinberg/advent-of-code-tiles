day = "18"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def calcArea(pipe, perimeter)
    area = 0
    for i in 0...(pipe.length - 1)
        area += det(pipe.slice(i, 2).transpose)
    end
    return (area.abs / 2) + perimeter / 2 + 1
end

def det(matrix)
    return matrix[0][0] * matrix[1][1] - matrix[1][0] * matrix[0][1]
end

def part1(input)
    coords = [[0, 0]]
    perimeter = 0
    for n in input
        dir, num, color = n.split(" ")
        perimeter += num.to_i
        lastC = coords.last
        if dir == "R"
            coords.append([lastC[0], lastC[1] + num.to_i])
        elsif dir == "L"
            coords.append([lastC[0], lastC[1] - num.to_i])
        elsif dir == "U"
            coords.append([lastC[0] - num.to_i, lastC[1]])
        elsif dir == "D"
            coords.append([lastC[0] + num.to_i, lastC[1]])
        end
    end
    return calcArea(coords, perimeter)

end

def part2(input)
    coords = [[0, 0]]
    perimeter = 0
    dirMap = {
        "0" => "R",
        "1" => "D",
        "2" => "L",
        "3" => "U"
    }
    for n in input
        color = n.split(" ")[2]
        dir = dirMap[color.split("")[7]]
        num = color.slice(2, 5).to_i(16)
        perimeter += num.to_i
        lastC = coords.last
        if dir == "R"
            coords.append([lastC[0], lastC[1] + num])
        elsif dir == "L"
            coords.append([lastC[0], lastC[1] - num])
        elsif dir == "U"
            coords.append([lastC[0] - num, lastC[1]])
        elsif dir == "D"
            coords.append([lastC[0] + num, lastC[1]])
        end
    end
    return calcArea(coords, perimeter)

end

puts part1(data)
puts part2(data)