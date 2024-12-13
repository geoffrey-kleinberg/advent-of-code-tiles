require 'set'

day = "21"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def makeMap(input)
    input = input.map { |i| i.split("") }
    for l in input
        if l.include? "S"
            l[l.index("S")] = "."
        end
    end
    return input
end

def getStart(input)
    for i in 0...input.length
        if input[i].index("S")
            return [i, input[i].index("S")]
        end
    end
end

def getNeighbors(input, loc)
    neighbors = [[loc[0] + 1, loc[1]], [loc[0] - 1, loc[1]], [loc[0], loc[1] + 1], [loc[0], loc[1] - 1]]
    return neighbors
end

def getNext(garden, current)
    height = garden.length
    width = garden[0].length
    total = Set[]
    for i in current
        total.merge(getNeighbors(garden, i).filter { |j| garden[j[0] % height][j[1] % width] == "." })
    end
    return total
        
end

def part1(input, count)
    start = getStart(input)
    garden = makeMap(input)
    possible = Set[start]
    for i in 1..count
        possible = getNext(garden, possible)
    end
    # print possible
    # puts
    return possible.size
end

def part2(input)
    start = getStart(input)
    garden = makeMap(input)

    steps = 202300 * 131 + 65

    # after 131n + 65
    # n = 0 -> whatever can be reached in 65 (within)
    # n = 1 -> 7819 (from the middle) + 4 * 3941 (whatever can be reached in 65 (within))
    # n = 2 -> 7819 * 4 + 7796 * 1 + 3941 * 9
    # n = 3 -> 7819 * (1 + 9) + 7796 * 4 + 3941 * 16
    # n = 2k -> 7819 * (4 + 16 + ...) + 7796 * (1 + 9 + ...) + 3941 * (2k + 1)^2
    k0 = 3941
    k1 = 35259
    k2 = 97807

    c = 3941
    a = 15615
    b = 15703
    return a * (202300 ** 2) + b * 202300 + c
end

# 21546903285465583641 is too high
# 21546902814822422191 is too high
# 639048438153396 is too low
# 639051580070841

# puts part1(data, 65)
# puts part1(data, 131 * 1 + 65)
# puts part1(data, 131 * 2 + 65)
# puts part1(data, 131 * 3 + 65)
# puts part1(data, 131 * 4 + 65)
puts part2(data)