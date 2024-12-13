day = "11"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    lines = input.map { |i| i.split("") }
    newLines = []
    for i in 0...(lines.length)
        newLines << lines[i]
        if lines[i].all? { |j| j == "." }
            newLines << lines[i]
        end
    end
    lines = newLines.transpose
    newLines = []
    for i in 0...(lines.length)
        newLines << lines[i]
        if lines[i].all? { |j| j == "." }
            newLines << lines[i]
        end
    end
    lines = newLines.transpose
    sum = 0
    locs = []
    for i in 0...(lines.length)
        for j in 0...(lines[i].length)
            if lines[i][j] == "#"
                locs << [i, j]
            end
        end
    end
    for l1 in locs
        for l2 in locs
            sum += (l1[0] - l2[0]).abs + (l1[1] - l2[1]).abs
        end
    end
    return sum / 2
end

def part2(input)
    lines = input.map { |i| i.split("") }
    locs = []
    for i in 0...(lines.length)
        for j in 0...(lines[i].length)
            if lines[i][j] == "#"
                locs << [i, j]
            end
        end
    end
    fullCols = []
    for i in 0...lines[0].length
        if lines.map { |j| j[i] }.all? { |j| j == "." }
            fullCols << i
        end
    end
    fullRows = []
    for i in 0...lines.length
        if lines[i].all? { |j| j == "." }
            fullRows << i
        end
    end
    sum = 0
    mult = 1000000
    for l1 in locs
        for l2 in locs
            thisDist = 0
            lowerX, largerX = [l1[1], l2[1]].min, [l1[1], l2[1]].max
            for i in lowerX...largerX
                if fullCols.include? i
                    thisDist += mult
                else
                    thisDist += 1
                end
            end
            lowerY, largerY = [l1[0], l2[0]].min, [l1[0], l2[0]].max
            for i in lowerY...largerY
                if fullRows.include? i
                    thisDist += mult
                else
                    thisDist += 1
                end
            end
            sum += thisDist
        end
    end
    return sum / 2
end

# puts part1(data)
puts part2(data)