require 'set'

day = "17"
file_name = "12-#{day}-18/sampleIn.txt"
# file_name = "12-#{day}-18/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def waterBelow(source, claySquares, yMax, water)
    if source[1] > yMax
        return 0
    end
    print source
    puts
    bottoms = [source]
    # total = 0
    while bottoms.length > 0
        cur = bottoms.shift
        water.add(cur)

        below = [cur[0], cur[1] + 1]
        next if below[1] > yMax
        
        # below = [cur[0], cur[1] + 1]
        # next if below[1] > yMax
        # if (claySquares.include? below or water.include? below)

        #     leftClay = false
        #     rightClay = false
        #     left = -1
        #     loop do
        #         leftSquare = [below[0] + left, below[1]]
        #         if claySquares.include? leftSquare
        #             leftClay = true
        #             break
        #         end
        #         bottomLeft = [below[0] + left, below[1] + 1]
        #         if not (claySquares.include? bottomLeft or water.include? bottomLeft)
        #             total += waterBelow(leftSquare, claySquares, yMax, water) + 1
        #             break
        #         else
        #             water.add(leftSquare)
        #         end
        #         left -= 1
        #     end
        #     right = 1
        #     loop do
        #         rightSquare = [below[0] + right, below[1]]
        #         if claySquares.include? rightSquare
        #             rightClay = true
        #             break
        #         end
        #         bottomRight = [below[0] + right, below[1] + 1]
        #         if not (claySquares.include? bottomRight or water.include? bottomRight)
        #             total += waterBelow(rightSquare, claySquares, yMax, water) + 1
        #             break
        #         else
        #             water.add(rightSquare)
        #         end
        #         right += 1
        #     end
        #     if rightClay and leftClay
        #         if [cur[0], cur[1] - 1] == source
        #             return -1
        #         end
        #         bottoms.append([cur[0], cur[1] - 1])
        #     end
        # else
        #     bottoms.append(below)
        # end
    end
    return -1
end


# 30000 is too low
def part1(input)
    claySquares = Set[]

    for line in input
        l1, l2 = line.split(", ")
        a1 = l1.split("=")[0]
        t1 = l1.split("=")[1].to_i
        t2 = l2.split("=")[1].split("..").map { |i| i.to_i }
        for i in t2[0]..t2[1]
            if a1 == "x"
                claySquares.add([t1, i])
            elsif a1 == "y"
                claySquares.add([i, t1])
            else
                raise "where"
            end
        end
    end
    yMin, yMax = claySquares.minmax { |i, j| i[1] <=> j[1] }.map { |i| i[1] }

    water = Set[]

    waterBelow([500, 0], claySquares, yMax, water)

    return water.size - 1
end

def part2(input)
    return input
end

puts part1(data)
# puts part2(data)