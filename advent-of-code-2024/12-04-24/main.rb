day = "04"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  count = 0
  lines = input.map { |i| i.split('')}

  locs = {}

  for i in 0...lines.length
    for j in 0...lines[i].length
      next if lines[i][j] != 'X'
      words = []
      if j >= 3
        words.append(lines[i][j] + lines[i][j - 1] + lines[i][j - 2] + lines[i][j - 3])
        if i >= 3
          words.append(lines[i][j] + lines[i - 1][j - 1] + lines[i - 2][j - 2] + lines[i - 3][j - 3])
        end
        if i <= lines.length - 4
          words.append(lines[i][j] + lines[i + 1][j - 1] + lines[i + 2][j - 2] + lines[i + 3][j - 3])
        end
      end
      if j <= lines[i].length - 4
        words.append(lines[i][j] + lines[i][j + 1] + lines[i][j + 2] + lines[i][j + 3])
        if i >= 3
          words.append(lines[i][j] + lines[i - 1][j + 1] + lines[i - 2][j + 2] + lines[i - 3][j + 3])
        end
        if i <= lines.length - 4
          words.append(lines[i][j] + lines[i + 1][j + 1] + lines[i + 2][j + 2] + lines[i + 3][j + 3])
        end
      end
      if i >= 3
        words.append(lines[i][j] + lines[i - 1][j] + lines[i - 2][j] + lines[i - 3][j])
      end
      if i <= lines.length - 4
        words.append(lines[i][j] + lines[i + 1][j] + lines[i + 2][j] + lines[i + 3][j])
      end
      count += words.count("XMAS")
    end
  end

  return count
end

def part2(input)
  count = 0
  lines = input.map { |i| i.split('')}

  for i in 0...lines.length
    for j in 0...lines[i].length
      next if lines[i][j] != 'A'
      top_left = nil
      top_right = nil
      bottom_left = nil
      bottom_right = nil
      if i != 0 and j != 0
        top_left = lines[i - 1][j - 1]
      end
      if i != 0 and j != input[i].length - 1
        top_right = lines[i - 1][j + 1]
      end
      if i != input.length - 1 and j != 0
        bottom_left = lines[i + 1][j - 1]
      end
      if i != input.length - 1 and j != input[i].length - 1
        bottom_right = lines[i + 1][j + 1]
      end
      next if not (top_left and top_right and bottom_left and bottom_right)
      letters = [top_left, top_right, bottom_left, bottom_right]
      if not (letters.count("M") == 2 and letters.count("S") == 2)
        next
      end
      if top_left != bottom_right
        count += 1
      end
    end
  end
  return count
end

puts part1(data)
# puts part2(data)