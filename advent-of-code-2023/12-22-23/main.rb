require 'set'

day = "22"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

class Brick

    attr_accessor :start, :finish, :supportedBy, :supporting, :occupied, :id, :maxId

    @@occupied = {}
    @@maxId = 0
    @@blocks = {}
    @@done = Set["ground"]
    @@occupiedSet = Set[]

    def initialize(start, finish)
        @id = @@maxId
        @@maxId += 1
        @start = start
        @finish = finish
        adding = false
        @@occupied[@id] = []
        if @start[0] != @finish[0]
            for i in @start[0]..@finish[0]
                @@occupied[@id].append([i, @start[1], @start[2]])
                @@occupiedSet.add([i, @start[1], @start[2]])
                adding = true
            end
        elsif @start[1] != @finish[1]
            for i in @start[1]..@finish[1]
                @@occupied[@id].append([@start[0], i, @start[2]])
                @@occupiedSet.add([@start[0], i, @start[2]])
                adding = true
            end
        elsif @start[2] != @finish[2]
            for i in @start[2]..@finish[2]
                @@occupied[@id].append([@start[0], @start[1], i])
                @@occupiedSet.add([@start[0], @start[1], i])
                adding = true
            end
        else
            @@occupied[@id].append(@start.clone)
            @@occupiedSet.add(@start.clone)
            adding = true
        end
        raise "ugh" if not adding
        @supportedBy = Set[]
        @supporting = Set[]
        @@blocks[@id] = self
    end

    def canDrop
        if @start[2] == 1 or @finish[2] == 1
            return false
        end
        if @start[0] == @finish[0]
            for i in @start[1]..@finish[1]
                if @@occupied.values.flatten(1).include? [@start[0], i, @start[2] - 1]
                    return false
                end
            end
            return true
        elsif @start[1] == @finish[1]
            for i in @start[0]..@finish[0]
                if @@occupied.values.flatten(1).include? [i, @start[1], @start[2] - 1]
                    return false
                end
            end
            return true
        else
            raise 'drop error'
        end
    end

    def clearSupports
        @supportedBy.clear
        @supporting.clear
    end

    def drop
        changed = false
        stopped = false
        while true
            if @start[2] == 1 or @finish[2] == 1
                @supportedBy.add("ground")
                return changed
            end
            if @start[1] != @finish[1]
                for i in @start[1]..@finish[1]
                    if @@occupiedSet.include? [@start[0], i, @start[2] - 1]
                        supporterId = @@occupied.select { |k, v| v.include? [@start[0], i, @start[2] - 1] }.keys
                        if supporterId.length != 1
                            print supporterId
                            puts
                            raise
                        end
                        supporterId = supporterId[0]
                        supporter = @@blocks[supporterId]
                        @supportedBy.add(supporter)
                        supporter.supporting.add(self)
                        stopped = true
                    end
                end
                if stopped
                    return changed
                end
                @start[2] -= 1
                @finish[2] -= 1
                for i in @@occupied[@id]
                    @@occupiedSet.delete(i)
                    i[2] -= 1
                    @@occupiedSet.add(i.clone)
                end
                changed = true
            elsif @start[0] != @finish[0]
                for i in @start[0]..@finish[0]
                    if @@occupiedSet.include? [i, @start[1], @start[2] - 1]
                        supporterId = @@occupied.select { |k, v| v.include? [i, @start[1], @start[2] - 1] }.keys
                        if supporterId.length != 1
                            print supporterId
                            puts
                            raise
                        end
                        supporterId = supporterId[0]
                        supporter = @@blocks[supporterId]
                        @supportedBy.add(supporter)
                        supporter.supporting.add(self)
                        stopped = true
                    end
                end
                if stopped
                    return changed
                end
                @start[2] -= 1
                @finish[2] -= 1
                for i in @@occupied[@id]
                    @@occupiedSet.delete(i)
                    i[2] -= 1
                    @@occupiedSet.add(i.clone)
                end
                changed = true
            else
                if @@occupiedSet.include? [@start[0], @start[1], @start[2] - 1]
                    supporterId = @@occupied.select { |k, v| v.include? [@start[0], @start[1], @start[2] - 1] }.keys
                    if supporterId.length != 1
                        print supporterId
                        puts
                        raise
                    end
                    supporterId = supporterId[0]
                    supporter = @@blocks[supporterId]
                    @supportedBy.add(supporter)
                    supporter.supporting.add(self)
                    stopped = true
                end
                if stopped
                    return changed
                end
                @@occupiedSet.delete(@finish)
                @@occupied[id].delete(@finish)
                @start[2] -= 1
                @finish[2] -= 1
                @@occupied[id].append(@start.clone)
                @@occupiedSet.add(@start.clone)
                changed = true
            end
        end
    end

    def str
        return "#{@id}: #{@start}, #{@finish}"
    end

    def self.occupied
        @@occupied
    end

    def self.done
        @@done
    end

    def supporting
        @supporting
    end

end

def part1(input)
    bricks = []
    puts "PROCESSING!"
    for line in input
        start, finish = line.split("~")
        bricks.append(Brick.new(start.split(",").map { |i| i.to_i }, finish.split(",").map { |i| i.to_i }))
    end
    count = bricks.length
    puts "DROPPING!"
    dropping = true
    brickCopy = bricks.clone
    while dropping
        dropping = false
        for i in brickCopy
            i.clearSupports
        end
        for i in brickCopy
            dropped = i.drop
            if dropped
                dropping = true
            end
        end
        for i in brickCopy
            settled = true
            for j in i.supportedBy
                if not Brick.done.include? j
                    settled = false
                end
            end
            if settled
                Brick.done.add(i)
                brickCopy.delete(i)
            end
        end
        puts brickCopy.length
    end
    puts "TESTING!"
    unsafe = Set[]
    for b in bricks
        if b.supportedBy.size == 1
            toAdd = b.supportedBy.to_a[0]
            next if toAdd == "ground"
            unsafe.add(toAdd)
        end
    end

    return count - unsafe.size
end

def part2(input)
    bricks = []
    puts "PROCESSING!"
    for line in input
        start, finish = line.split("~")
        bricks.append(Brick.new(start.split(",").map { |i| i.to_i }, finish.split(",").map { |i| i.to_i }))
    end
    count = bricks.length
    puts "DROPPING!"
    dropping = true
    brickCopy = bricks.clone
    while dropping
        dropping = false
        for i in brickCopy
            i.clearSupports
        end
        for i in brickCopy
            dropped = i.drop
            if dropped
                dropping = true
            end
        end
        for i in brickCopy
            settled = true
            for j in i.supportedBy
                if not Brick.done.include? j
                    settled = false
                end
            end
            if settled
                Brick.done.add(i)
                brickCopy.delete(i)
            end
        end
        puts brickCopy.length
    end

    puts "TESTING!"
    count = 0
    for i in bricks
        fallen = Set[i]
        lastSize = fallen.size
        while true
            nextFallen = Set[]
            for j in fallen
                for b in j.supporting
                    if fallen.superset? b.supportedBy
                        nextFallen.add(b)
                    end
                end
            end
            fallen.merge(nextFallen)
            break if lastSize == fallen.size
            lastSize = fallen.size
        end
        count += fallen.size - 1
    end
    return count
end

puts part1(data)
puts part2(data)