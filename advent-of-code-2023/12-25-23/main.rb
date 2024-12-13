require 'set'

day = "25"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def kargers(input)
    graph = {}
    groups = {}
    for i in input
        node, connections = i.split(": ")
        connections = connections.split(" ")
        if not graph[node]
            graph[node] = []
        end
        for c in connections
            graph[node].append(c)
        end
        if not groups[node]
            groups[node] = Set[node]
        end
        for j in connections
            if not graph[j]
                graph[j] = []
            end
            if not groups[j]
                groups[j] = Set[j]
            end
            graph[j].append(node)
        end
    end
    for i in graph.keys
        graph[i] = graph[i].to_set
        graph[i] = graph[i].to_a
    end
    # puts graph.size
    while graph.size > 2
        # gives the correct result for sample data
        # e1 = graph.keys.sample(random: Random.new(14))
        # e2 = graph[e1].sample(random: Random.new(1))
        e1 = graph.keys.sample
        e2 = graph[e1].sample
        # puts e1
        # puts e2
        graph[e1] = graph[e1] + graph[e2]
        for v in graph.values
            a = v.count(e2)
            for i in 0...a
                v.append(e1)
            end
            v.delete(e2)
        end
        graph[e1].delete(e1)
        graph.delete(e2)
        groups[e1] = groups[e1] + groups[e2]
        groups.delete(e2)
    end
    # print groups
    # puts
    sizes = groups.values.map { |i| i.length }
    return sizes[0] * sizes[1], graph.values.map { |i| i.size }.max
end

def part1(input)
    while true
        ans, size = kargers(input)
        puts ans, size
        if size == 3
            return ans
        end
    end
end

puts part1(data)