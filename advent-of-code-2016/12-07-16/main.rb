require 'set'

day = "07"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def abba(line)
    line = line.split("")
    bracketed = false
    valid = false
    for i in 0...(line.length - 3)
        curString = line.slice(i, 4)
        if curString.length != 4
            raise "off by one"
        end
        if curString.include? "["
            bracketed = true
        end
        if curString.include? "]"
            bracketed = false
        end
        if curString.slice(0) == curString.slice(3) and curString.slice(1) == curString.slice(2) and curString.slice(0) != curString.slice(1)
            if bracketed
                return false
            end
            valid = true
        end
    end
    return valid
end

def ssl(line)
    line = line.split("")
    aba = Set[]
    bab = Set[]
    for i in 0...(line.length - 2)
        curString = line.slice(i, 3)
        if curString.length != 3
            raise "off by one"
        end
        if curString.include? "["
            bracketed = true
        end
        if curString.include? "]"
            bracketed = false
        end
        if curString.slice(0) == curString.slice(2) and curString.slice(0) != curString.slice(1)
            if bracketed
                bab.add(curString.join)
            else
                aba.add(curString.join)
            end
        end
    end
    for i in aba
        opposite = i.slice(1) + i.slice(0) + i.slice(1)
        if bab.include? opposite
            return true
        end
    end
    return false
end

def part1(input)
    count = 0
    for line in input
        if abba(line)
            count += 1
        end
        # puts line
        # puts abba(line)
    end
    return count
end

def part2(input)
    count = 0
    for line in input
        break if line == ""
        if ssl(line)
            count += 1
        end
        # puts line
        # puts ssl(line)
    end
    return count
end

# puts part1(data)
puts part2(data)