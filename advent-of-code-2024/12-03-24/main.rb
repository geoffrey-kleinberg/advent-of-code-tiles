day = "03"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    digits = (0..9).to_a.map { |i| i.to_s }
    sum = 0
    for l in input
        line = l.split('')
        for i in 0...line.length
            if line[i...(i+4)].join == 'mul('
                # puts i
                loc = i + 4
                num1 = ''
                first_num = true
                num2 = ''
                valid = true
                found_end = false
                while loc < i + 12
                #   puts line[loc]
                if not valid
                    break
                end
                if digits.include? line[loc]
                    if first_num
                        num1 += line[loc]
                    else
                        num2 += line[loc]
                    end
                else
                    # puts "comma"
                    if line[loc] == ',' and first_num
                    first_num = false
                    #   puts "comma"
                    elsif line[loc] == ')'
                    loc = i + 12
                    found_end = true
                    else
                    valid = false
                    end
                end
                loc += 1
                end
                # puts
                # puts
                if valid and found_end
                sum += num1.to_i * num2.to_i
                end
            end
        end
    end
    return sum
end

def part2(input)
    digits = (0..9).to_a.map { |i| i.to_s }
    doing = true
    sum = 0
    for l in input
        line = l.split('')
        for i in 0...line.length
            if line[i...(i+4)].join == 'mul(' and doing
                # puts i
                loc = i + 4
                num1 = ''
                first_num = true
                num2 = ''
                valid = true
                found_end = false
                while loc < i + 12
                #   puts line[loc]
                if not valid
                    break
                end
                if digits.include? line[loc]
                    if first_num
                        num1 += line[loc]
                    else
                        num2 += line[loc]
                    end
                else
                    # puts "comma"
                    if line[loc] == ',' and first_num
                    first_num = false
                    #   puts "comma"
                    elsif line[loc] == ')'
                    loc = i + 12
                    found_end = true
                    else
                    valid = false
                    end
                end
                loc += 1
                end
                # puts
                # puts
                if valid and found_end
                sum += num1.to_i * num2.to_i
                end
            elsif line[i...(i+4)].join == 'do()'
                doing = true
            elsif line[i...(i+7)].join == 'don\'t()'
                doing = false
            end
        end
    end
    return sum
end

# puts part1(data)
puts part2(data)