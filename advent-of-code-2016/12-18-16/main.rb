require 'set'

day = "18"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  firstRow = input[0].split("")
  tiles = [firstRow]

  while tiles.length < 40
    lastRow = tiles[-1]
    nextRow = []
    for i in 0...lastRow.length

      left = nil
      right = nil

      if i == 0
        left = "."
      else
        left = lastRow[i - 1]
      end

      if i == lastRow.length - 1
        right = "."
      else
        right = lastRow[i + 1]
      end

      center = lastRow[i]

      if center == "^" and right == "^" and left == "."
        nextRow.append("^")
      elsif left == "^" and center == "^" and right == "."
        nextRow.append("^")
      elsif left == "^" and center == "." and right == "."
        nextRow.append("^")
      elsif left == "." and center == "." and right == "^"
        nextRow.append("^")
      else
        nextRow.append(".")
      end
      
    end
    tiles.append(nextRow)
  end

  # for i in tiles
  #   puts i.join
  # end

  return tiles.flatten.count(".")
end

def part2(input)
  lastRow = input[0].split("")

  safe = lastRow.count(".")

  r = 1

  while r < 400000
    nextRow = []
    for i in 0...lastRow.length

      left = nil
      right = nil

      if i == 0
        left = "."
      else
        left = lastRow[i - 1]
      end

      if i == lastRow.length - 1
        right = "."
      else
        right = lastRow[i + 1]
      end

      center = lastRow[i]

      if center == "^" and right == "^" and left == "."
        nextRow.append("^")
      elsif left == "^" and center == "^" and right == "."
        nextRow.append("^")
      elsif left == "^" and center == "." and right == "."
        nextRow.append("^")
      elsif left == "." and center == "." and right == "^"
        nextRow.append("^")
      else
        nextRow.append(".")
      end
      
    end

    lastRow = nextRow
    safe += nextRow.count(".")
    r += 1
    if r % 10000 == 0
      puts r
    end
  end

  # for i in tiles
  #   puts i.join
  # end

  return safe
end

# puts part1(data)
puts part2(data)