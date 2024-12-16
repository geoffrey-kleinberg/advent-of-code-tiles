require 'set'

day = "11"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getDist(steps)
    n = steps.count("n")
    s = steps.count("s")
    ne = steps.count("ne")
    se = steps.count("se")
    nw = steps.count("nw")
    sw = steps.count("sw")


    n1 = [nw, ne].min
    s1 = [sw, se].min

    n = n + n1
    s = s + s1

    ne -= n1
    nw -= n1
    se -= s1
    sw -= s1

    v1 = [n, s].min

    n -= v1
    s -= v1

    if n == 0
        if ne == 0 and se == 0
            c1 = [s, nw].min
            return sw + s + nw - c1
        elsif ne == 0 and sw == 0
            c1 = [se, nw].min
            se -= c1
            nw -= c1
            if nw == 0
              return s + se
            else
              return s
            end
        elsif nw == 0 and se == 0
            c1 = [sw, ne].min
            sw -= c1
            ne -= c1
            if ne == 0
              return s + sw
            else
              return s
            end
        elsif nw == 0 and sw == 0
            c1 = [s, ne].min
            return se + s + ne - c1
        end
    elsif s == 0
        if se == 0 and ne == 0
            c1 = [n, sw].min
            return nw + n + sw - c1
        elsif se == 0 and nw == 0
            c1 = [ne, sw].min
            ne -= c1
            sw -= c1
            if sw == 0
              return n + ne
            else
              return n
            end
        elsif sw == 0 and ne == 0
            c1 = [nw, se].min
            nw -= c1
            se -= c1
            if se == 0
              return n + nw
            else
              return n
            end
        elsif sw == 0 and nw == 0
            c1 = [n, se].min
            return ne + n + se - c1
        end
    end

    print steps
    puts

    raise 'debug, please'
end

def part1(input)
    steps = input[0].split(',')

    return getDist(steps)
end

def part2(input)
    steps = input[0].split(',')
    longest = -1 * Float::INFINITY

    for i in 0...steps.length
      dist = getDist(steps[0...i])
      longest = [dist, longest].max
    end
    return longest
end

# puts part1(data)
puts part2(data)