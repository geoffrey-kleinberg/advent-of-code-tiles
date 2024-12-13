require 'digest'

day = "05"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    md5 = Digest::MD5.new
    code = input[0]
    password = ""
    num = 0
    while password.length < 8
        md5.update code
        md5.update num.to_s
        hex = md5.hexdigest
        if hex.slice(0, 5) == "00000"
            password += hex.slice(5)
            puts num
            puts password
        end
        num += 1
        md5.reset
    end
    return password
end

def part2(input)
    md5 = Digest::MD5.new
    code = input[0]
    password = Array.new(8)
    found = 0
    num = 0
    while found < 8
        md5.update code
        md5.update num.to_s
        hex = md5.hexdigest
        if hex.slice(0, 5) == "00000"
            position = hex.slice(5).to_i(16)
            if position <= 7 and not password[position]
                found += 1
                password[position] = hex.slice(6)
            end
            puts num
            puts password.map { |i| i ? i : "_" }.join
        end
        num += 1
        md5.reset
    end
    return password.join
end

# puts part1(data)
puts part2(data)