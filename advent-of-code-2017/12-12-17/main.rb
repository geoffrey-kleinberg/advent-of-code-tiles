require 'set'

day = "12"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    connections = {
    }

    for line in input
      start, con = line.split(" <-> ")
      if not connections[start.to_i]
        connections[start.to_i] = Set[]
      end
      for c in con.split(", ")
        connections[start.to_i].add(c.to_i)
        if not connections[c.to_i]
          connections[c.to_i] = Set[]
        end
        connections[c.to_i].add(start.to_i)
      end
    end

    zero_group = Set[]

    queue = [0]
    while queue.length > 0
      cur = queue.shift
      zero_group.add(cur)

      for con in connections[cur]
        next if zero_group.include? con
        queue.append(con)
      end
    end

    return zero_group.size
end

def part2(input)
    connections = {
    }

    nodes = (0...2000).to_a

    for line in input
      start, con = line.split(" <-> ")
      if not connections[start.to_i]
        connections[start.to_i] = Set[]
      end
      for c in con.split(", ")
        connections[start.to_i].add(c.to_i)
        if not connections[c.to_i]
          connections[c.to_i] = Set[]
        end
        connections[c.to_i].add(start.to_i)
      end
    end

    groups = []

    while nodes.length > 0
      group = Set[]

      queue = [nodes.min]
      while queue.length > 0
        cur = queue.shift
        group.add(cur)
        nodes.delete(cur)

        for con in connections[cur]
            next if group.include? con
            queue.append(con)
        end
      end
      groups.append(group)
    end

    return groups.size
end

# puts part1(data)
puts part2(data)