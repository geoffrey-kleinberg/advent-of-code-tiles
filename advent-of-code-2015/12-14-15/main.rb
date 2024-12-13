file = 'samplein.txt'
file = 'input.txt'
lines = []
File.open(file) do |f|
  f.each do |i|
    lines << i
  end
end

def getSpeeds(lines)
  speeds = {}
  for i in lines
    words = i.split(" ")
    speeds[words[0]] = [words[3], words[6], words[13]].map { |j| j.to_i }
  end
  return speeds
end

def getIntervals(speeds)
  intervals = {}
  for i in speeds.keys
    intervals[i] = [speeds[i][0] * speeds[i][1], speeds[i][1] + speeds[i][2]]
  end
  return intervals
end

def getDistances(speeds, intervals, time)
  distances = {}
  for i in intervals.keys
    totalReps = (time / intervals[i][1]).floor
    remaining = time % intervals[i][1]
    finalDist = speeds[i][0] * [speeds[i][1], remaining].min
    distances[i] = totalReps * intervals[i][0] + finalDist
  end
  return distances
  
end

def part1(lines)
  seconds = 2503
  speeds = getSpeeds(lines)
  intervals = getIntervals(speeds)
  distances = getDistances(speeds, intervals, seconds)
  return distances.values.max
end

def part2(lines)
  seconds = 2503
  speeds = getSpeeds(lines)
  intervals = getIntervals(speeds)
  points = {}
  for i in intervals.keys
    points[i] = 0
  end
  for i in 1..seconds
    distances = getDistances(speeds, intervals, i)
    for j in distances.keys
      if distances[j] == distances.values.max
        points[j] += 1
      end
    end
  end
  return points.values.max
end

puts part1(lines)
puts part2(lines)