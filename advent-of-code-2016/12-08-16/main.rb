day = "08"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    cols = 50
    rows = 6
    lights = []
    for iter in 0...rows
        lights.append(["."] * cols)
    end
    for line in input
        pieces = line.split(" ")
        if pieces[0] == "rect"
            dimensions = pieces[1].split("x").map { |i| i.to_i }
            for i in 0...dimensions[0]
                for j in 0...dimensions[1]
                    lights[j][i] = "#"  
                end  
            end
        else
            if pieces[1] == "row"
                rowNum = pieces[2].split("=")[1].to_i
                rotateAmount = pieces[4].to_i
                newRow = ["."] * cols
                for i in 0...cols
                    newRow[(i + rotateAmount) % cols] = lights[rowNum][i]
                end  
                lights[rowNum] = newRow
            else
                colNum = pieces[2].split("=")[1].to_i
                rotateAmount = pieces[4].to_i
                colCopy = lights.map { |i| i[colNum] }.flatten
                for i in 0...rows
                    lights[i][colNum] = colCopy[(i - rotateAmount) % rows]
                end
            end
        end

        # puts lights.map { |i| i.join }
        # puts
    end
    puts lights.map { |i| i.join }
    return lights.flatten.count("#"), lights.map { |i| i.join }
end

def part2(input)
    return part1(input)[1]
end

puts part1(data)[0]
# puts part2(data)