day = "12"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    sum = 0
    count = 0
    for line in input
        springs, nums = line.split(" ")
        nums = nums.split(",").map { |i| i.to_i }
        recursive = getPossibleRecursive(springs, nums, {})
        sum += recursive
    end
    return sum
end

def getPossibleRecursive(springs, nums, memo)
    if not springs
        return 0
    end
    if memo[[springs, nums]]
        return memo[[springs, nums]]
    end
    possible = 0
    cur = nums[0]
    for loc in 0..(springs.length - cur)
        next if springs.slice(loc, cur).split("").any? { |i| i == "." }
        next if springs.slice(loc + cur) == "#"
        next if springs.length < nums.sum
        next if springs.slice(0, loc).split("").any? { |i| i == "#" }
        if loc != 0
            next if springs.slice(loc - 1) == "#"
        end
        if nums.length == 1
            future = newSprings = springs.slice(loc + cur + 1, springs.length - loc - cur - 1)
            if not future
                possible += 1
            elsif future.split("").all? { |i| i != "#" }
                possible += 1
            end
        else
            newSprings = springs.slice(loc + cur + 1, springs.length - loc - cur - 1)
            newNums = nums.slice(1, springs.length - 1)
            possible += getPossibleRecursive(newSprings, newNums, memo)
        end
    end
    memo[[springs, nums]] = possible
    return possible
end

def part2(input)
    sum = 0
    for line in input
        springs, nums = line.split(" ")
        nums = nums.split(",").map { |i| i.to_i }
        springs = ([springs] * 5).join("?")
        nums = nums * 5
        sum += getPossibleRecursive(springs, nums, {})
    end
    return sum
end

puts part1(data)
puts part2(data)