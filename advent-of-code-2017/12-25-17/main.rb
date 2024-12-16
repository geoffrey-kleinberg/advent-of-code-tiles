require 'set'

day = "25"
file_name = "12-#{day}-17/sampleIn.txt"
# file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    tape = {
    }

    tape.default = 0

    cursor = 0

    state = "A"


    for step in 0...12399302
      if state == "A"
        if tape[cursor] == 0
            tape[cursor] = 1
            cursor += 1
            state = "B"
        else
            tape[cursor] = 0
            cursor += 1
            state = "C"
        end
      elsif state == "B"
        if tape[cursor] == 0
            cursor -= 1
            state = "A"
        else
            tape[cursor] = 0
            cursor += 1
            state = "D"
        end
      elsif state == "C"
        if tape[cursor] == 0
            tape[cursor] = 1
            cursor += 1
            state = "D"
        else
            tape[cursor] = 1
            cursor += 1
            state = "A"
        end
      elsif state == "D"
        if tape[cursor] == 0
            tape[cursor] = 1
            cursor -= 1
            state = "E"
        else
            tape[cursor] = 0
            cursor -= 1
            state = "D"
        end
      elsif state == "E"
        if tape[cursor] == 0
            tape[cursor] = 1
            cursor += 1
            state = "F"
        else
            tape[cursor] = 1
            cursor -= 1
            state = "B"
        end
      elsif state == "F"
        if tape[cursor] == 0
            tape[cursor] = 1
            cursor += 1
            state = "A"
        else
            tape[cursor] = 1
            cursor += 1
            state = "E"
        end
      end
    end

    return tape.values.sum
end

puts part1(data)
# puts part2(data)