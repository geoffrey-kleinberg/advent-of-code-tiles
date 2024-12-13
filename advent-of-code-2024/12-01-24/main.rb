day = "01"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    num_pairs = input.map { |i| i.split('   ') }
    firsts = num_pairs.map { |i| i[0].to_i }.sort
    seconds = num_pairs.map { |i| i[1].to_i }.sort

    total = 0

    for i in 0...firsts.length
      total += (seconds[i] - firsts[i]).abs
    end
    
    return total
end

def part2(input)
    num_pairs = input.map { |i| i.split('   ') }
    firsts = num_pairs.map { |i| i[0].to_i }.sort
    seconds = num_pairs.map { |i| i[1].to_i }.sort

    total = 0

    for i in 0...firsts.length
      total += firsts[i] * (seconds.count(firsts[i]))
    end

    return total
end

puts part1(data)
puts part2(data)