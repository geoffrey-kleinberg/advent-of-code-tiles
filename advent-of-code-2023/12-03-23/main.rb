file_name = '12-03-23/sampleIn.txt'
file_name = '12-03-23/input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def getAdjacent(curr, maxX, maxY)
    options = []
    for i in -1..1
        for j in -1..1
            x = curr[0] + i
            y = curr[1] + j
            if 0 <= x and x < maxX and 0 <= y and y < maxY
                options.append([x, y])
            end
        end
    end
    return options
end

def part1(input)
    nums = '1234567890'
    sum = 0
    for line in 0...input.length
        curNum = '0'
        isValid = false
        for letter in 0...input[line].length
            char = input[line].slice(letter)
            if nums.include? char
                curNum += char
                for option in getAdjacent([line, letter], input.length, input[line].length)
                    match = input[option[0]].slice(option[1])
                    if (not match == '.') and (not nums.include? match)
                        isValid = true
                    end
                end
            else
                if curNum.to_i != 0
                    puts curNum.to_i
                    puts isValid
                end
                sum += curNum.to_i if isValid
                isValid = false
                curNum = '0'
            end
        end
        sum += curNum.to_i if isValid
    end
    return sum
end

def part2(input)
    nums = '1234567890'
    sum = 0
    gears = {}
    for line in 0...input.length
        curNum = '0'
        isValid = false
        possibleGear = false
        gearLoc = []
        for letter in 0...input[line].length
            char = input[line].slice(letter)
            if nums.include? char
                curNum += char
                for option in getAdjacent([line, letter], input.length, input[line].length)
                    match = input[option[0]].slice(option[1])
                    if (not match == '.') and (not nums.include? match)
                        isValid = true
                        if (match == '*')
                            possibleGear = true
                            gearLoc = [option[0], option[1]]
                        end
                    end
                end
            else
                isValid = false
                if possibleGear
                    if gears[gearLoc]
                        gears[gearLoc].append(curNum.to_i)
                    else
                        gears[gearLoc] = [curNum.to_i]
                    end
                end
                possibleGear = false
                gearLoc = []
                curNum = '0'
            end
        end
        if possibleGear
            if gears[gearLoc]
                gears[gearLoc].append(curNum.to_i)
            else
                gears[gearLoc] = [curNum.to_i]
            end
        end
        possibleGear = false
        gearLoc = []
    end
    for i in gears.keys
        if gears[i].length == 2
            sum += gears[i][0] * gears[i][1]
        end
    end
    return sum
end

# puts part1(data)
puts part2(data)