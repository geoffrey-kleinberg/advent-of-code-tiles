day = "19"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def parseInput(input)
    workflows1 = []
    parts1 = []
    wf = true
    for i in input
        if i == ""
            wf = false
            next
        end
        if wf
            workflows1 << i
        else
            parts1 << i
        end
    end
    workflows = {}
    for w in workflows1
        name = w.split("{")[0]
        ops = w.split("{")[1].delete_suffix("}")
        ops = ops.split(",")
        workflows[name] = ops
    end
    parts = []
    for p in parts1
        parts.append({})
        thisP = p.delete_prefix("{").delete_suffix("}")
        parts[parts.length - 1] = Hash[thisP.split(",").map { |i| i.split("=") } ]
    end
    return workflows, parts

end

def part1(input)
    workflows, parts = parseInput(input)
    rejected = []
    accepted = []
    for p in parts
        done = false
        wf = "in"
        while not done
            current = workflows[wf]
            for i in current
                if not i.include? ":"
                    wf = i
                    break
                else
                    first, second = i.split(":")
                    var = first.slice(0)
                    goal = p[var].to_s + first.slice(1, first.length - 1)
                    if eval(goal)
                        wf = second
                        break
                    end
                end
            end
            if wf == "A"
                accepted.append(p)
                done = true
            elsif wf == "R"
                rejected.append(p)
                done = true
            end
        end
    end
    return accepted.map { |i| i.values.map { |j| j.to_i }.sum }.sum
end

class Hypercube

    attr_accessor :x1, :x2, :m1, :m2, :a1, :a2, :s1, :s2

    def initialize(x1, x2, m1, m2, a1, a2, s1, s2)
        @x1, @x2, @m1, @m2, @a1, @a2, @s1, @s2 = x1, x2, m1, m2, a1, a2, s1, s2
    end

    def str
        return "(#{@x1}, #{@x2}) (#{@m1}, #{@m2}) (#{@a1}, #{@a2}) (#{@s1}, #{@s2})"
    end

    def split(axis, sign, value)
        if sign == "<"
            if axis == "x"
                if @x2 < value
                    return self.clone, nil
                elsif @x1 > value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, value - 1, @m1, @m2, @a1, @a2, @s1, @s2)
                    remaining = Hypercube.new(value, @x2, @m1, @m2, @a1, @a2, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "m"
                if @m2 < value
                    return self.clone, nil
                elsif @m1 > value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, @m1, value - 1, @a1, @a2, @s1, @s2)
                    remaining = Hypercube.new(@x1, @x2, value, @m2, @a1, @a2, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "a"
                if @a2 < value
                    return self.clone, nil
                elsif @a1 > value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, @m1, @m2, @a1, value - 1, @s1, @s2)
                    remaining = Hypercube.new(@x1, @x2, @m1, @m2, value, @a2, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "s"
                if @s2 < value
                    return self.clone, nil
                elsif @s1 > value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, @m1, @m2, @a1, @a2, @s1, value - 1)
                    remaining = Hypercube.new(@x1, @x2, @m1, @m2, @a1, @a2, value, @s2)
                    return [possible, remaining]
                end
            end
        elsif sign == ">"
            if axis == "x"
                if @x1 > value
                    return self.clone, nil
                elsif @x2 < value
                    return nil, self.clone
                else
                    possible = Hypercube.new(value + 1, @x2, @m1, @m2, @a1, @a2, @s1, @s2)
                    remaining = Hypercube.new(@x1, value, @m1, @m2, @a1, @a2, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "m"
                if @m1 > value
                    return self.clone, nil
                elsif @m2 < value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, value + 1, @m2, @a1, @a2, @s1, @s2)
                    remaining = Hypercube.new(@x1, @x2, @m1, value, @a1, @a2, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "a"
                if @a1 > value
                    return self.clone, nil
                elsif @a2 < value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, @m1, @m2, value + 1, @a2, @s1, @s2)
                    remaining = Hypercube.new(@x1, @x2, @m1, @m2, @a1, value, @s1, @s2)
                    return [possible, remaining]
                end
            elsif axis == "s"
                if @s1 > value
                    return self.clone, nil
                elsif @s2 < value
                    return nil, self.clone
                else
                    possible = Hypercube.new(@x1, @x2, @m1, @m2, @a1, @a2, value + 1, @s2)
                    remaining = Hypercube.new(@x1, @x2, @m1, @m2, @a1, @a2, @s1, value)
                    return [possible, remaining]
                end
            end
        else
            raise "no sign"
        end
    end

    def clone
        return Hypercube.new(@x1, @x2, @m1, @m2, @a1, @a2, @s1, @s2)
    end

    def volume
        return (@x2 - @x1 + 1) * (@m2 - @m1 + 1) * (@a2 - @a1 + 1) * (@s2 - @s1 + 1)
    end
end

def part2(input)
    workflows, parts = parseInput(input)
    total = 4000 ** 4
    entries = {}
    for i in workflows.keys
        entries[i] = []
    end
    entries["A"] = []
    entries["R"] = []
    entries["in"] = [Hypercube.new(1, 4000, 1, 4000, 1, 4000, 1, 4000)]
    toCheck = ["in"]
    while toCheck.length > 0
        cur = toCheck[0]
        wf = workflows[cur]
        for i in wf
            if i.include? ":"
                first, second = i.split(":")
                var = first.slice(0)
                dest = second
            else
                dest = i
            end
            if not ["A", "R"].include? dest
                toCheck.append(dest)
            end
        end
        for hc in entries[cur]
            remaining = hc.clone
            for i in wf
                if i.include? ":"
                    first, second = i.split(":")
                    var = first.slice(0)
                    sign = first.slice(1)
                    value = first.slice(2, first.length - 2).to_i
                    dest = second
                    possible, remaining = remaining.split(var, sign, value)
                else
                    dest = i
                    possible = remaining
                end
                entries[dest].append(possible) if possible
                break if not remaining
            end
        end
        toCheck.delete_at(0)
    end
    return entries["A"].sum { |i| i.volume }
end

# puts part1(data)
puts part2(data)