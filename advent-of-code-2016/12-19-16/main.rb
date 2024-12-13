require 'set'

day = "19"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  count = input[0].to_i

  neighbors = {}
  for i in 1..count
    neighbors[i] = i + 1
    if i == count
      neighbors[i] = 1
    end
  end

  current = 1

  while neighbors.size > 1
    neighbor = neighbors[current]
    neighbors[current] = neighbors[neighbor]

    neighbors.delete(neighbor)

    current = neighbors[current]
  end

  return current
end


# recursive algorithm goes too deep
def getWinnerPosition(count)
  if count == 2
    return 0
  end

  removed = count / 2

  smallWinner = getWinnerPosition(count - 1)

  if smallWinner + 1 >= removed
    return (smallWinner + 2) % count
  else
    return (smallWinner + 1) % count
  end
end

def part2(input)
  count = input[0].to_i

  prevWinner = 0

  for i in 1..count
    removed = i / 2
    if prevWinner + 1 >= removed
      prevWinner = (prevWinner + 2) % i
    else
      prevWinner = (prevWinner + 1) % i
    end
  end

  return prevWinner + 1
end

# puts part1(data)
puts part2(data)