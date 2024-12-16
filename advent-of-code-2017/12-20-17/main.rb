require 'set'

day = "20"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    locs = []
    vels = []
    accs = []
    for line in input
      comps = line.split(", ")
      ps, vs, as = comps.map { |i| i.chomp(">").split("<")[1].split(",").map { |j| j.to_i } }
      locs.append(ps)
      vels.append(vs)
      accs.append(as)
    end

    idx = -1
    best = Float::INFINITY
    for i in 0...accs.length
      score = accs[i].map { |j| j.abs }.sum
      if score < best
        best = score
        idx = i
      end
    end
    
    return idx
end

def getCollision(p0, v0, a0, p1, v1, a1)
  # return all integer values such that they collide
  if a0 != a1
    a = a0.to_f / 2 - a1.to_f / 2
    b = v0.to_f - a1.to_f / 2 - v1.to_f + a0.to_f / 2
    c = p0.to_f - p1.to_f

    discriminant = b * b - 4 * a * c
    if discriminant < 0
        return []
    elsif discriminant == 0
        return [-1 * b / (2 * a)]
    else
        sqrtD = Math.sqrt(discriminant)
        return [(-1 * b + sqrtD) / (2 * a), (-1 * b - sqrtD) / (2 * a)]
    end
  elsif v0 != v1
    a = v0.to_f - v1.to_f
    b = p0.to_f - p1.to_f
    return [-1 * b / a]
  elsif p0 != p1
    return []
  else
    return "always"
  end
end

def getPos(p, v, a, t)
  return p + t * v + a * (t * (t + 1)) / 2
end

def part2(input)
    locs = []
    vels = []
    accs = []
    for line in input
      comps = line.split(", ")
      ps, vs, as = comps.map { |i| i.chomp(">").split("<")[1].split(",").map { |j| j.to_i } }
      locs.append(ps)
      vels.append(vs)
      accs.append(as)
    end

    collisions = {

    }

    # let's do some algebra
    for i in 0...locs.length
      for j in (i + 1)...locs.length
        for axis in 0...3
          p0, v0, a0, p1, a1, v1 = locs[i][axis], vels[i][axis], accs[i][axis], locs[j][axis], vels[j][axis], accs[j][axis]
          collide = getCollision(p0, v0, a0, p1, a1, v1)
          if collide != "always"
            break
          end
        end

        if collide == "always"
          collide = [0]
        end
        for t in collide
          intT = t.round

          next if intT < 0
          x0 = getPos(locs[i][0], vels[i][0], accs[i][0], intT)
          x1 = getPos(locs[j][0], vels[j][0], accs[j][0], intT)
          y0 = getPos(locs[i][1], vels[i][1], accs[i][1], intT)
          y1 = getPos(locs[j][1], vels[j][1], accs[j][1], intT)
          z0 = getPos(locs[i][2], vels[i][2], accs[i][2], intT)
          z1 = getPos(locs[j][2], vels[j][2], accs[j][2], intT)

          if x0 == x1 and y0 == y1 and z0 == z1
            if not collisions[intT]
              collisions[intT] = []
            end
            collisions[intT].append([i, j])
          end
        end
      end
    end

    vanquished = Set[]

    for i in collisions.keys.sort
      vanquisedNow = Set[]
      for pair in collisions[i]
        if (not vanquished.include? pair[0]) and (not vanquished.include? pair[1])
          vanquisedNow.add(pair[0])
          vanquisedNow.add(pair[1])
        end
      end

      vanquished += vanquisedNow
    end

    return locs.size - vanquished.size
end

# puts part1(data)
puts part2(data)