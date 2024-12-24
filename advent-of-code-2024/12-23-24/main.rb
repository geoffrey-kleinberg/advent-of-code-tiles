require 'set'

day = "23"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    graph = {}
    edges = input.map { |i| i.split("-") }
    for e in edges
      if not graph[e[0]]
        graph[e[0]] = Set[]
      end
      if not graph[e[1]]
        graph[e[1]] = Set[]
      end
      graph[e[0]].add(e[1])
      graph[e[1]].add(e[0])
    end

    goalCount = 0

    for e in edges
      for v in graph[e[0]]
        if graph[e[1]].include? v
          if e[0][0] == "t" or e[1][0] == "t" or v[0] == "t"
            goalCount += 1
          end
        end
      end
    end

    return goalCount / 3
end

def part2(input)
    graph = {}
    edges = input.map { |i| i.split("-") }
    for e in edges
      if not graph[e[0]]
        graph[e[0]] = Set[]
      end
      if not graph[e[1]]
        graph[e[1]] = Set[]
      end
      graph[e[0]].add(e[1])
      graph[e[1]].add(e[0])
    end

    sizeNCliques = edges.map { |i| i.to_set }.to_set

    while sizeNCliques.size != 1
      sizeN1Cliques = Set[]
      for c in sizeNCliques
        arr = c.to_a
        for v in graph[arr[0]]
          if c.all? { |i| graph[i].include? v }
            newClique = c + Set[v]
            sizeN1Cliques.add(newClique)
          end
        end
      end
      sizeNCliques = sizeN1Cliques
    end

    return sizeNCliques.to_a[0].to_a.sort.join(",")
end

# puts part1(data)
puts part2(data)