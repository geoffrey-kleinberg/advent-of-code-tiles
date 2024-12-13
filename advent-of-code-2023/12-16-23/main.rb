require 'set'

day = "16"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getCount(start, mirrors)
    visited = Set[]
    states = Set[]
    beams = [start]
    height = mirrors.length
    width = mirrors[0].length
    while beams.length >= 1
        b = beams[0]
        if not states.add? b
            beams.delete_at(0)
            next
        end
        loc = b.slice(0, 2)
        visited.add(loc)
        dir = b[2]
        newLoc = []
        if dir == "r"
            newLoc = [b[0], b[1] + 1]
        elsif dir == "l"
            newLoc = [b[0], b[1] - 1]
        elsif dir == "u"
            newLoc = [b[0] - 1, b[1]]
        elsif dir == "d"
            newLoc = [b[0] + 1, b[1]]
        else
            puts "error"
            puts dir
            print b 
            puts
            print beams
            puts
            raise 'error'
        end
        if newLoc[0] < 0 or newLoc[0] >= height
            beams.delete_at(0)
            next
        end
        if newLoc[1] < 0 or newLoc[1] >= width
            beams.delete_at(0)
            next
        end
        symbol = mirrors[newLoc[0]][newLoc[1]]
        if symbol == "/"
            if dir == "r"
                newLoc << "u"
            elsif dir == "u"
                newLoc << "r"
            elsif dir == "d"
                newLoc << "l"
            elsif dir == "l"
                newLoc << "d"
            end
        end
        if symbol == "\\"
            if dir == "r"
                newLoc << "d"
            elsif dir == "d"
                newLoc << "r"
            elsif dir == "u"
                newLoc << "l"
            elsif dir == "l"
                newLoc << "u"
            end
        end
        otherLight = nil
        if symbol == "-"
            if dir == "u" or dir == "d"
                newLoc << "l"
                otherLight = newLoc.clone
                otherLight[2] = "r"
            else
                newLoc << dir
            end
        end
        if symbol == "|"
            if dir == "l" or dir == "r"
                newLoc << "u"
                otherLight = newLoc.clone
                otherLight[2] = "d"
            else
                newLoc << dir
            end
        end
        if symbol == "."
            newLoc << dir
        end
        beams << newLoc
        if otherLight
            beams << otherLight
        end
        beams.delete_at(0)
    end
    # print visited
    # puts
    return visited.size - 1
end

def part1(input)
    start = [0, -1, "r"]
    mirrors = input.map { |i| i.split("") }
    return getCount(start, mirrors)
end

def part2(input)
    height = input.length
    width = input[0].length
    mirrors = input.map { |i| i.split("") }
    starts = []
    for i in 0...height
        starts.append([i, -1, "r"])
        starts.append([i, width, "l"])
    end
    for i in 0...width
        starts.append([-1, i, "d"])
        starts.append([height, i, "u"])
    end
    best = -1
    for i in starts
        best = [getCount(i, mirrors), best].max
    end
    return best
end

# puts part1(data)
puts part2(data)