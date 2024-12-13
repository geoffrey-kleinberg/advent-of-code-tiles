day = "14"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def calcWeight(input)
    sum = 0
    for i in 0...input.length
        sum += input[i].count("O") * (input.length - i)
    end
    return sum
end

def spinN(input)
    for y in 0...input.length
        line = input[y].split("")
        for x in 0...line.length
            if input[y][x] == "O"
                newRow = y - 1
                while newRow >= 0
                    if input[newRow][x] != "."
                        break
                    end
                    newRow -= 1
                end
                input[y][x] = "."
                input[newRow + 1][x] = "O"
            end
        end
    end
    return input
end

def spinS(input)
    for i in 0...input.length
        y = input.length - i - 1
        line = input[y]
        for x in 0...line.length
            if input[y][x] == "O"
                newRow = y + 1
                while newRow < input.length
                    if input[newRow][x] != "."
                        break
                    end
                    newRow += 1
                end
                input[y][x] = "."
                input[newRow - 1][x] = "O"
            end
        end
    end
    return input
end

def spinW(input)
    for y in 0...input.length
        line = input[y]
        for x in 0...line.length
            if input[y][x] == "O"
                newCol = x - 1
                while newCol >= 0
                    if input[y][newCol] != "."
                        break
                    end
                    newCol -= 1
                end
                input[y][x] = "."
                input[y][newCol + 1] = "O"
            end
        end
    end
    return input
end

def spinE(input)
    for y in 0...input.length
        line = input[y]
        for j in 0...line.length
            x = line.length - j - 1
            if input[y][x] == "O"
                newCol = x + 1
                while newCol < line.length
                    if input[y][newCol] != "."
                        break
                    end
                    newCol += 1
                end
                input[y][x] = "."
                input[y][newCol - 1] = "O"
            end
        end
    end
    return input
end

def spin(input, dir)
    if dir == "N"
        return spinN(input)
    elsif dir == "S"
        return spinS(input)
    elsif dir == "E"
        return spinE(input)
    elsif dir == "W"
        return spinW(input)
    else
        raise 'ahh'
    end
end

def part1(input)
    input = spinN(input)
    return calcWeight(input)
end

def part2(input)
    dirs = ["N", "W", "S", "E"]
    seen = {}
    iterations = 1000000000
    for cycle in 0...iterations
        if seen[input.join("-")]
            start = seen[input.join("-")]
            bigCycle = cycle - start
            offset = iterations - start
            mod = offset % bigCycle
            # puts bigCycle
            # puts offset
            # puts mod
            for i in seen.keys
                # print i
                # puts
                # puts seen[i]
                # puts calcWeight(i.split("-"))
                if seen[i] == start + mod
                    return calcWeight(i.split("-"))
                end
            end
            break
        end
        seen[input.join("-")] = cycle
        for dir in dirs
            input = spin(input, dir)
        end
    end

    return calcWeight(input)
end

puts part1(data)
puts part2(data)