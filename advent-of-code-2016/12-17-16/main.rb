require 'set'
require 'digest'

day = "17"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
  password = input[0]

  queue = [
    [[0, 0], ""]
  ]

  md5 = Digest::MD5.new

  while queue.length > 0
    cur = queue.shift
    loc = cur[0]
    path = cur[1]
    if loc == [3, 3]
      return path
    end

    md5.reset
    md5.update(password + path)
    hash = md5.hexdigest.slice(0, 4).split("")

    dirs = ['U', 'D', 'L', 'R']

    dMap = {
      'U' => [-1, 0],
      'D' => [1, 0],
      'L' => [0, -1],
      'R' => [0, 1]
    }
    

    for d in 0...dirs.length
      dir = dirs[d]
      next if dir == 'U' and loc[0] == 0
      next if dir == 'D' and loc[0] == 3
      next if dir == 'R' and loc[1] == 3
      next if dir == 'L' and loc[1] == 0

      next if not ['b', 'c', 'd', 'e', 'f'].include? hash[d]

      queue.append([
        [loc[0] + dMap[dir][0], loc[1] + dMap[dir][1]], path + dir
      ])

    end
  end
end

def getLongestPath(x, y, path, password, md5)
  if x > 3 or y > 3 or x < 0 or y < 0
    return -1
  end
  if x == 3 and y == 3
    return path.length
  end

  md5.reset
  md5.update(password + path)
  hash = md5.hexdigest.slice(0, 4).split("")

  dirs = ['U', 'D', 'L', 'R']
  validDirs = []

  for i in 0...4
    validDirs.append(dirs[i]) if ['b', 'c', 'd', 'e', 'f'].include? hash[i]
  end
  if validDirs.length == 0
    return -1
  end

  dMap = {
    'U' => [-1, 0],
    'D' => [1, 0],
    'L' => [0, -1],
    'R' => [0, 1]
  }

  longests = []
  for d in validDirs
    longests.append(getLongestPath(x + dMap[d][0], y + dMap[d][1], path + d, password, md5))
  end

  return longests.max

end

def part2(input)
  password = input[0]
  md5 = Digest::MD5.new

  return getLongestPath(0, 0, '', password, md5)
end

# puts part1(data)
puts part2(data)