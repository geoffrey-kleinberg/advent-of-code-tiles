
file_name = '12-01-23/sampleIn.txt'
file_name = '12-01-23/input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    nums = '1234567890'
    sum = 0
    for line in input do
        num = ''
        found_first = false
        first_num = ''
        last_num = ''
        for char in line.split('')
            if nums.include? char and not found_first
                first_num = char
                found_first = true
            end
            if nums.include? char
                last_num = char
            end
        end
        sum += (first_num + last_num).to_i
    end
    return sum
end



def part2(input)

    nums = '123456789'.split('')
    nums += ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
    sum = 0
    for line in input do
        first_num = nums.min { |i, j| (line.index(i) ? line.index(i) : Float::INFINITY) <=> (line.index(j) ? line.index(j) : Float::INFINITY) }
        last_num = nums.max { |i, j| (line.rindex(i) ? line.rindex(i) : (-1 * Float::INFINITY)) <=> (line.rindex(j) ? line.rindex(j) : (-1 * Float::INFINITY)) }
        sum += 10 * (1 + nums.index(first_num) % 9) + (1 + nums.index(last_num) % 9)
    end
    return sum
end

puts part1(data)
puts part2(data)