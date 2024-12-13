require 'set'

day = "23"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

class PathManager

    def initialize(start, goal)
        @@seen = Set[]
        @@maxId = 0
        @@paths = {}
        @@finalPaths = []
        @@seen.add(start)
        @@goal = goal
    end

    def self.getPossibleNext(path, input, part)
        y = path.mostRecent[0]
        x = path.mostRecent[1]
        if part == 2 or input[y][x] == "."
            possible = [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]]
        elsif input[y][x] == ">"
            possible = [[y, x + 1]]
        elsif input[y][x] == "<"
            possible = [[y, x - 1]]
        elsif input[y][x] == "^"
            possible = [[y - 1, x]]
        elsif input[y][x] == "v"
            possible = [[y + 1, x]]
        else
            raise "possible next"
        end

        possible = possible.filter { |i| i[0] >= 0 and i[0] < input.length and i[1] >= 0 and i[1] < input.length }
        possible = possible.filter { |i| input[i[0]][i[1]] != "#" }
        return possible
    end


    def self.deletePath(id)
        @@paths.delete(id)
    end

    def self.seen
        @@seen
    end

    def self.paths
        @@paths
    end

    def self.nextId
        @@maxId += 1
    end

    def self.goal
        @@goal
    end

    def self.finalPaths
        @@finalPaths
    end

end

class Path

    attr_accessor :mostRecent, :path, :id, :orderedPath

    def initialize(path, start, ordered)
        @mostRecent = start
        @path = path
        @orderedPath = ordered
        @id = PathManager.nextId
        PathManager.paths[@id] = self
        return self
    end

    def getNextPaths(input, part=1)
        nextPoints = PathManager.getPossibleNext(self, input, part)
        nextPaths = []
        for i in nextPoints
            next if @path.include? i
            if PathManager.seen.include? i
                # print "filtering: "
                # print PathManager.paths.size
                # print " -> "
                if part == 1
                    PathManager.paths.delete_if { |k, v| v.path.include? i }
                else
                    # num = PathManager.paths.count { |k, v| v.path.include? i }
                    # if num == 2
                    #     raise "oy vey"
                    # end
                    # PathManager.paths.each do |k, v|
                    #     next if not v.path.include? i
                    #     # merge this path with that one
                    #     toMerge = v
                    #     iIndex = toMerge.orderedPath.index(i)
                    #     iIndex2 = @orderedPath.length + 1
                    #     if iIndex > iIndex2

                    # end
                end
            end
            thisPath = self.clone
            thisPath.addVertex(i)
            nextPaths.append(thisPath)
            if i == PathManager.goal
                PathManager.finalPaths.append(thisPath)
                # puts thisPath.path.size
            end
        end
        PathManager.deletePath(self.id)
        return nextPaths
    end

    def addVertex(point)
        @path.add(point)
        @orderedPath.append(point)
        @mostRecent = point
        PathManager.seen.add(point)
    end

    def clone
        return Path.new(@path.clone, @mostRecent.clone, @orderedPath.clone)
    end

    def str
        return @path.to_s
    end

end

def part1(input)
    input = input.map { |i| i.split("")}
    start = [0, 1]
    goal = [input.length - 1, input[0].length - 2]
    pm = PathManager.new(start, goal)
    firstPath = Path.new(Set[start], start, [start])
    paths = [firstPath]
    reps = 0
    while paths.length > 0
        for i in paths
            i.getNextPaths(input)
        end
        paths = PathManager.paths.values
    end
    return PathManager.finalPaths.map { |i| i.path.size }.max - 1
end

def part2(input)
    # input = input.map { |i| i.split("")}
    # start = [0, 1]
    # goal = [input.length - 1, input[0].length - 2]
    # pm = PathManager.new(start, goal)
    # firstPath = Path.new(Set[start], start, [start])
    # paths = [firstPath]
    # reps = 0
    # while paths.length > 0
    #     for i in paths
    #         i.getNextPaths(input, part=2)
    #     end
    #     paths = PathManager.paths.values
    # end
    # longest = PathManager.finalPaths.max { |i, j| i.path.size <=> j.path.size }.path
    # for i in 0...input.length
    #     for j in 0...input[i].length
    #         if longest.include? [i, j]
    #             print "O"
    #         else
    #             print input[i][j]
    #         end
    #     end
    #     puts
    # end
    input = input.map { |i| i.split("")}
    betterGraph = {}
    start = [0, 1]
    goal = [input.length - 1, input[0].length - 2]
    queue = [[start]]
    reps = 0
    seen = Set[]
    while queue.length > 0
        curPath = queue[0]
        cur = curPath.last
        seen.add(cur)
        y = cur[0]
        x = cur[1]
        possible = [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]]
        possible = possible.filter { |i| i[0] >= 0 and i[0] < input.length and i[1] >= 0 and i[1] < input.length }
        possible = possible.filter { |i| input[i[0]][i[1]] != "#" }
        # possible.delete_if { |i| seen.include? i }
        if possible.length > 2 or (possible.length == 1 and cur == goal)
            if not betterGraph[curPath[0]]
                betterGraph[curPath[0]] = {}
            end
            betterGraph[curPath[0]][cur] = curPath.length - 1
            # if not betterGraph[cur]
            #     betterGraph[cur] = {}
            # end
            # betterGraph[cur][curPath[0]] = curPath.length
            for i in possible
                if not curPath.include? i and not betterGraph.keys.include? cur
                    queue.append([cur, i])
                end
            end
        else
            for i in possible
                queue.append(curPath.clone + [i]) if not curPath.include? i
            end
        end
        queue.delete_at(0)
        # print queue
        # puts
        # reps += 1
        # break if reps == 20
    end
    betterGraph[goal] = {}
    for k in betterGraph.keys
        for j in betterGraph[k].keys
            betterGraph[j][k] = betterGraph[k][j]
        end
    end
    for k in betterGraph.keys
        for j in betterGraph[k].keys
            betterGraph[k][j] = betterGraph[k][j]
        end
    end
    puts "Processed, finding longest path"
    longest = getLongestPath(start, goal, betterGraph, Set[])
    return longest

end

def getLongestPath(start, goal, graph, visited)
    if start == goal
        return 0
    end
    longest = -1 * Float::INFINITY
    visit = visited.clone
    visit.add(start)
    neighbors = graph[start].keys
    for i in neighbors
        next if visit.include? i
        dist = getLongestPath(i, goal, graph, visit)
        dist += graph[start][i]
        if dist > longest
            longest = dist
        end
    end
    return longest

end

# puts part1(data)
puts part2(data)