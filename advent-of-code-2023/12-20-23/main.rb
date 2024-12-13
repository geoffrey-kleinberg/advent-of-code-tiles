day = "20"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

class Mod

    attr_accessor :destinations, :name

    def initialize(name, destinations)
        @name = name
        @destinations = destinations
    end

    def sendPulse(type)
        for dest in @destinations
            dest.pulse(type, @name)
        end
    end
end

class FlipFlop < Mod

    attr_accessor :state

    def initialize(name, destinations)
        @name = name
        @destinations = destinations
        @state = "off"
    end

    def pulse(type, sender)
        if type == "high"
            return false
        elsif type == "low"
            toSend = (@state == "on") ? "low" : "high"
            @state = (@state == "on") ? "off" : "on"
            return toSend
            self.sendPulse(toSend)
        else
            raise "no type"
        end
    end

end

class Conjuction < Mod

    attr_accessor :lastPulse

    def initialize(name, destinations)
        @destinations = destinations
        @name = name
        @lastPulse = {}
    end

    def pulse(type, sender)
        @lastPulse[sender] = type
        if @lastPulse.values.all? { |i| i == "high" }
            return "low"
            self.sendPulse("low")
        else
            return "high"
            self.sendPulse("high")
        end
    end

end

class Broadcast < Mod

    def pulse(type, sender)
        return type
        self.sendPulse(type)
    end

end

class Output < Mod
end

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)

    # first set up all the modules
    # in a dict with { name => obj }
    modules = {}
    conjunctions = []
    for line in input
        name, destinations = line.split(" -> ")
        destinations = destinations.split(", ")
        if name != "broadcaster"
            type = name.slice(0)
            name = name.slice(1, name.length - 1)
            if type == "%"
                modules[name] = FlipFlop.new(name, destinations)
            elsif type == "&"
                modules[name] = Conjuction.new(name, destinations)
                conjunctions.append(name)
            else
                raise "bad type"
            end
        else
            modules[name] = Broadcast.new(name, destinations)
        end
    end

    for m in modules.keys
        mod = modules[m]
        for d in mod.destinations
            if conjunctions.include? d
                modules[d].lastPulse[mod.name] = "low"
            end
        end
    end

    high = 0
    low = 0

    for run in 1..1000
        # puts
        # puts
        # puts "Press #{run}:"
        queue = [["broadcaster", "low", "button"]]
        while queue.length > 0
            # print queue[0].reverse
            # puts
            (queue[0][1] == "low") ? low += 1 : high += 1
            if not modules.keys.include? queue[0][0]
                queue.delete_at(0)
                next
            end
            cur = modules[queue[0][0]]
            nextPulse = cur.pulse(queue[0][1], queue[0][2])
            if nextPulse
                for d in cur.destinations
                    dest = modules[d]
                    queue.append([d, nextPulse, cur.name])
                end
            end
            queue.delete_at(0)
        end
        
    end

    puts low, high
    return low * high
end

def part2(input)

    # first set up all the modules
    # in a dict with { name => obj }
    modules = {}
    conjunctions = []
    for line in input
        name, destinations = line.split(" -> ")
        destinations = destinations.split(", ")
        if name != "broadcaster"
            type = name.slice(0)
            name = name.slice(1, name.length - 1)
            if type == "%"
                modules[name] = FlipFlop.new(name, destinations)
            elsif type == "&"
                modules[name] = Conjuction.new(name, destinations)
                conjunctions.append(name)
            else
                raise "bad type"
            end
        else
            modules[name] = Broadcast.new(name, destinations)
        end
    end

    zhInputs = {}

    for m in modules.keys
        mod = modules[m]
        for d in mod.destinations
            if conjunctions.include? d
                modules[d].lastPulse[mod.name] = "low"
            end
            if d == "zh"
                zhInputs[m] = nil
            end
        end
    end

    run = 1
    while true
        queue = [["broadcaster", "low", "button"]]
        while queue.length > 0
            if not modules.keys.include? queue[0][0]
                queue.delete_at(0)
                next
            end
            cur = modules[queue[0][0]]
            nextPulse = cur.pulse(queue[0][1], queue[0][2])
            if nextPulse
                for d in cur.destinations
                    dest = modules[d]
                    queue.append([d, nextPulse, cur.name])
                end
            end
            for i in zhInputs.keys
                if queue[0][2] == i and queue[0][1] == "high"
                    zhInputs[i] = run
                end
            end
            if zhInputs.values.all? { |i| i }
                return zhInputs.values.inject(1) { |prod, i| prod * i }
            end
            queue.delete_at(0)
        end
        run += 1
    end
end

# puts part1(data)
puts part2(data)