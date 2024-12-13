day = "24"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

class Parametric

    attr_accessor :position, :velocities

    def initialize(position, velocities)
        @position = position
        @velocities = velocities
    end

    def self.intersect2D(p1, p2)
        x0 = p1.position[0]
        a0 = p1.velocities[0]
        x1 = p2.position[0]
        a1 = p2.velocities[0]

        y0 = p1.position[1]
        b0 = p1.velocities[1]
        y1 = p2.position[1]
        b1 = p2.velocities[1]

        return nil if (a0 * b1 - a1 * b0 == 0)

        t1 = (b0 * (x1 - x0) - a0 * (y1 - y0)) / (a0 * b1 - a1 * b0)
        t0 = (x1 - x0 + a1 * t1) / a0
        x = x0 + a0 * t0
        y = y0 + b0 * t0

        return [x, y, t0, t1]
    end

    def self.intersect3D?(p1, p2)
        twoDInt = Parametric.intersect2D(p1, p2)
        if twoDInt
            t0 = twoDInt[2]
            t1 = twoDInt[3]
            if t1 != t0 or t0 < 0
                return false
            end
            z0 = p1.position[2]
            c0 = p1.velocities[2]
            z1 = p2.position[2]
            c1 = p2.velocities[2]
            return z0 + c0 * t0 == z1 + c1 * t1
        end
        return false
    end
end

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    hailstones = []
    for i in input
        positions, velocities = i.split(" @ ").map { |j| j.split(", ").map { |k| k.to_f } }
        hailstones.append(Parametric.new(positions, velocities))
    end
    count = 0
    cMin = 200000000000000
    cMax = 400000000000000
    for a in 0...hailstones.length
        for b in (a + 1)...hailstones.length
            h1 = hailstones[a]
            h2 = hailstones[b]
            collision = Parametric.intersect2D(h1, h2)
            next if not collision
            next if collision[2] < 0 or collision[3] < 0
            next if collision[0] < cMin or collision[0] > cMax or collision[1] < cMin or collision[1] > cMax
        end
    end
    return count
end

def rowSubtract(r1, r2)
    result = []
    raise if not r1.length == r2.length
    for i in 0...r1.length
        result.append(r1[i] - r2[i])
    end
    return result
end

def solveMatrix(matrix)
    copy = matrix.clone
    for i in 0...matrix.length
        pivot = matrix[i][i]
        for j in 0...matrix.length
            next if i == j
            next if matrix[j][i] == 0
            mult = pivot
            rowCopy = matrix[j].map { |k| k * mult }
            iCopy = matrix[i].map { |k| k * matrix[j][i]}
            matrix[j] = rowSubtract(rowCopy, iCopy)
        end
    end
    for i in 0...matrix.length
        pivot = matrix[i][i]
        matrix[i] = matrix[i].map { |j| j / pivot }
    end
    return matrix.map { |i| i.last}
end

def part2(input)
    hailstones = []
    for i in input
        positions, velocities = i.split(" @ ").map { |j| j.split(", ").map { |k| k.to_i } }
        hailstones.append(Parametric.new(positions, velocities))
    end
    xs = []
    ys = []
    zs = []
    as = []
    bs = []
    cs = []
    for i in 0...5
        xs[i], ys[i], zs[i] = hailstones[i].position
        as[i], bs[i], cs[i] = hailstones[i].velocities
    end
    matrix = [
        [ys[1] - ys[0], xs[0] - xs[1], bs[0] - bs[1], as[1] - as[0], bs[0] * xs[0] + as[1] * ys[1] - as[0] * ys[0] - bs[1] * xs[1]],
        [ys[2] - ys[0], xs[0] - xs[2], bs[0] - bs[2], as[2] - as[0], bs[0] * xs[0] + as[2] * ys[2] - as[0] * ys[0] - bs[2] * xs[2]],
        [ys[3] - ys[0], xs[0] - xs[3], bs[0] - bs[3], as[3] - as[0], bs[0] * xs[0] + as[3] * ys[3] - as[0] * ys[0] - bs[3] * xs[3]],
        [ys[4] - ys[0], xs[0] - xs[4], bs[0] - bs[4], as[4] - as[0], bs[0] * xs[0] + as[4] * ys[4] - as[0] * ys[0] - bs[4] * xs[4]]
    ]
    answer = solveMatrix(matrix)
    a = answer[0]
    b = answer[1]
    x = answer[2]
    y = answer[3]
    matrix = [
        [zs[1] - zs[0], xs[0] - xs[1], cs[0] - cs[1], as[1] - as[0], cs[0] * xs[0] + as[1] * zs[1] - as[0] * zs[0] - cs[1] * xs[1]],
        [zs[2] - zs[0], xs[0] - xs[2], cs[0] - cs[2], as[2] - as[0], cs[0] * xs[0] + as[2] * zs[2] - as[0] * zs[0] - cs[2] * xs[2]],
        [zs[3] - zs[0], xs[0] - xs[3], cs[0] - cs[3], as[3] - as[0], cs[0] * xs[0] + as[3] * zs[3] - as[0] * zs[0] - cs[3] * xs[3]],
        [zs[4] - zs[0], xs[0] - xs[4], cs[0] - cs[4], as[4] - as[0], cs[0] * xs[0] + as[4] * zs[4] - as[0] * zs[0] - cs[4] * xs[4]]
    ]
    answer = solveMatrix(matrix)
    c = answer[1]
    z = answer[3]
    thrown = Parametric.new([x, y, z], [a, b, c])
    for i in hailstones
        if not Parametric.intersect3D?(thrown, i)
            raise "oops"
        end
    end
    return x.round + y.round + z.round
end

# 885093461440403 is too low

# puts part1(data)
puts part2(data)