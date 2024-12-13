require 'set'

day = "08"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    instructions = input[0].split("")
    network = {}
    for lineNum in 2...input.length
        line = input[lineNum]
        node = line.split(" = ")[0]
        left = line.split(" = ")[1].split(", ")[0].delete_prefix("(")
        right = line.split(" = ")[1].split(", ")[1].delete_suffix(")")
        network[node] = [left, right]
    end
    count = 0
    curr = 'AAA'
    while curr != 'ZZZ'
        move = instructions[count % instructions.length]
        if move == 'L'
            curr = network[curr][0]
        elsif move == 'R'
            curr = network[curr][1]
        else
            raise 'mistake'
        end
        count += 1
    end
    return count
end

def part2(input)
    instructions = input[0].split("")
    network = {}
    starts = []
    for lineNum in 2...input.length
        line = input[lineNum]
        node = line.split(" = ")[0]
        if node.slice(2) == 'A'
            starts << node
        end
        left = line.split(" = ")[1].split(", ")[0].delete_prefix("(")
        right = line.split(" = ")[1].split(", ")[1].delete_suffix(")")
        network[node] = [left, right]
    end
    firsts = []
    cycles = []
    repeat = instructions.length
    for start in starts
        first = nil
        cycle = nil
        curr = start
        last = 0
        for count in 0...100000
            if first and cycle
                next
            end
            move = instructions[count % repeat]
            if move == "L"
                curr = network[curr][0]
            elsif move == "R"
                curr = network[curr][1]
            else
                raise 'mistake'
            end
            if curr.slice(2) == 'Z'
                if not first
                    first = count + 1
                elsif not cycle
                    cycle = (count - last) / repeat
                else
                    break
                end
                last = count
            end
        end
        firsts << first
        cycles << cycle
    end
    return intersect(firsts, cycles)
end

def intersect(firsts, cycles)
    intersect = int2([firsts[0], firsts[1]], [cycles[0], cycles[1]])
    for i in 2...firsts.length
        intersect = int2([intersect[0], firsts[i]], [intersect[1], cycles[i]])
    end
    return intersect[0]
end

def int2(firsts, cycles)
    loc = firsts[0]
    while (loc - firsts[1]) % (307 * cycles[1]) != 0
        loc += cycles[0] * 307
    end
    return [loc, cycles[0] * cycles[1]]
end

# puts part1(data)
puts part2(data)