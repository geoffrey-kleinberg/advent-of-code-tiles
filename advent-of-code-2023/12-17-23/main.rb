require 'set'

day = "17"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def calcSum(path, graph)
    sum = 0
    for i in path.slice(1, path.length - 1)
        sum += graph[i[0]][i[1]].to_i
    end
    return sum
end

def getPossibleNext(curNode, graph, least, most)
    possibleDirs = {
        "s" => ["r", "d"],
        "r" => ["d", "u"],
        "l" => ["d", "u"],
        "d" => ["l", "r"],
        "u" => ["r", "l"]
    }
    possibleNext = []
    for dir in possibleDirs[curNode[2].slice(0)]
        for dist in least..most
            if dir == "u"
                possibleNext << [curNode[0] - dist, curNode[1]]
            elsif dir == "d"
                possibleNext << [curNode[0] + dist, curNode[1]]
            elsif dir == "l"
                possibleNext << [curNode[0], curNode[1] - dist]
            elsif dir == "r"
                possibleNext << [curNode[0], curNode[1] + dist]
            end
            possibleNext.last.append(dir + dist.to_s)
        end
    end
    possibleNext.delete_if { |i| i.slice(0, 2).any? { |j| j < 0 } }
    possibleNext.delete_if { |i| i[0] >= graph.length }
    possibleNext.delete_if { |i| i[1] >= graph[0].length }

    return possibleNext

end

def part1(input)
    sumTime = 0
    graph = input.map { |i| i.split("").map { |j| j.to_i } }
    start = [[0, 0, "s"]]
    height = graph.length
    width = graph[0].length
    destination = [height - 1, width - 1]
    seen = Set[]
    queue = {
        height + width => [start]
    }
    weights = {}
    while queue.size > 0
        shortest = queue.keys.min
        curPath = queue[shortest][0]
        curNode = curPath.last
        prev = weights[curPath.first(curPath.length - 1)]
        curDist = nil
        if prev
            curDist = prev + calcSum2(curPath.last(2), graph)
        else
            curDist = calcSum2(curPath, graph)
        end
        weights[curPath] = curDist
        if curNode.first(2) == destination
            puts sumTime
            return curDist
        end
        if seen.include? (curNode)
            queue[shortest].delete_at(0)
            if queue[shortest].length == 0
                queue.delete(shortest)
            end
            next
        end
        possibleNext = getPossibleNext(curNode, graph, 1, 3)
        for possible in possibleNext
            nextPath = curPath.clone
            nextPath << possible
            dist = (height - possible[0]) + (width - possible[1]) + curDist + calcSum2(nextPath.last(2), graph)
            if queue[dist]
                queue[dist].append(nextPath)
            else
                queue[dist] = [nextPath]
            end
        end
        seen.add(curNode)
        # puts seen.size if seen.size % 1000 == 0
        queue[shortest].delete_at(0)
        if queue[shortest].length == 0
            queue.delete(shortest)
        end
    end
    return 0
end

def calcSum2(path, graph)
    total = 0
    for i in 0...(path.length - 1)
        start = path[i]
        finish = path[i + 1]
        if start[0] == finish[0]
            lower, higher = [start[1], finish[1]].sort
            for j in lower..higher
                total += graph[start[0]][j]
            end
        elsif start[1] == finish[1]
            lower, higher = [start[0], finish[0]].sort
            for j in lower..higher
                total += graph[j][start[1]]
            end
        else
            raise 'huh'
        end
        total -= graph[start[0]][start[1]]
    end
    return total
end

def part2(input)
    graph = input.map { |i| i.split("").map { |j| j.to_i } }
    start = [[0, 0, "s"]]
    height = graph.length
    width = graph[0].length
    destination = [height - 1, width - 1]
    seen = Set[]
    queue = {
        height + width => [start]
    }
    while queue.size > 0
        shortest = queue.keys.min
        curPath = queue[shortest][0]
        curNode = curPath.last
        curDist = calcSum2(curPath, graph)
        if curNode.first(2) == destination
            return curDist
        end
        if seen.include? (curNode)
            queue[shortest].delete_at(0)
            if queue[shortest].length == 0
                queue.delete(shortest)
            end
            next
        end
        possibleNext = getPossibleNext(curNode, graph, 4, 10)
        for possible in possibleNext
            nextPath = curPath.clone
            nextPath << possible
            dist = (height - possible[0]) + (width - possible[1]) + curDist + calcSum2(nextPath.last(2), graph)
            if queue[dist]
                queue[dist].append(nextPath)
            else
                queue[dist] = [nextPath]
            end
        end
        seen.add(curNode)
        # puts seen.size if seen.size % 1000 == 0
        queue[shortest].delete_at(0)
        if queue[shortest].length == 0
            queue.delete(shortest)
        end
    end
    return 0
end

puts part1(data)
puts part2(data)