require 'set'

day = "13"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    ranges = {

    }
    locs = {

    }
    moving = {

    }
    locs.default = -1
    for line in input
      depth, range = line.split(": ").map { |i| i.to_i }
      ranges[depth] = range
      locs[depth] = 0
      moving[depth] = 1
    end

    score = 0

    for t in 0..ranges.keys.max
      if locs[t] == 0
        score += t * ranges[t]
      end
      for k in ranges.keys
        locs[k] += moving[k]
        if locs[k] == 0
          moving[k] = 1
        end
        if locs[k] == ranges[k] - 1
          moving[k] = -1
        end
      end
    end

    return score
end

def part2(input)
    ranges = {

    }
    locs = {

    }
    moving = {

    }
    locs.default = -1
    for line in input
      depth, range = line.split(": ").map { |i| i.to_i }
      ranges[depth] = range
      locs[depth] = 0
      moving[depth] = 1
    end

    delays = [0]
    t = 0

    while true

      delays.delete_if { |i| locs[t - i] == 0 }
      if delays.min and delays.min + ranges.keys.max <= t
        return delays.min
      end

      for k in ranges.keys
        locs[k] += moving[k]
        if locs[k] == 0
            moving[k] = 1
        end
        if locs[k] == ranges[k] - 1
            moving[k] = -1
        end
      end

      t += 1
      delays.append(t)

    end
end

# puts part1(data)
puts part2(data)