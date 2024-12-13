day = "15"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    words = input[0].split(",").map { |i| i.split("") }
    return words.inject(0) { |sum, i| sum + i.inject(0) { |hsh, i| ((hsh + i.ord) * 17) % 256}}
end

def getHash(str)
    return str.split("").inject(0) { |sum, i| ((sum + i.ord) * 17) % 256 }
end

def part2(input)
    instructions = input[0].split(",")
    boxes = {}
    for step in instructions
        if step.include? "="
            key, lens = step.split("=")
            box = getHash(key)
            lens = lens.to_i
            if boxes[box]
                if boxes[box].map { |i| i[0] }.include? key
                    loc = boxes[box].find_index { |i| i[0] == key }
                    boxes[box][loc] = [key, lens]
                else
                    boxes[box].append([key, lens])
                end
            else
                boxes[box] = [[key, lens]]
            end
        elsif step.include? "-"
            key = step.split("-")[0]
            box = getHash(key)
            if boxes[box]
                boxes[box].delete_if { |i| i[0] == key }
            end
        else
            raise 'error'
        end
    end
    sum = 0
    for b in boxes.keys
        s = 0
        boxes[b].each.with_index do |i, ind|
            s += i[1] * (ind + 1)
        end
        sum += s * (b + 1)
    end
    return sum
end

# puts part1(data)
puts part2(data)