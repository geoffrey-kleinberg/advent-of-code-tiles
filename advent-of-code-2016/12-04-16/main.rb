day = "04"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

class Array

    def stable_sort
        yield 
        n = 0
        sort_by { |x| n += 1; [x, n] }
    end

end

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    total = 0
    for line in input
        values, checkSum = line.split("[")
        checkSum = checkSum.chomp("]")
        letters = values.split("-")
        sector = letters.pop.to_i
        letters = letters.join
        counts = {}
        for i in letters.split("")
            if not counts[i]
                counts[i] = 0
            end
            counts[i] -= 1
        end
        sorted = counts.keys.sort
        n = 0
        sorted = sorted.map { |a| n += 1; [[counts[a], n], a] }
        sorted = sorted.sort { |a, b| a[0] <=> b[0] }
        sorted = sorted.map { |a| a[1] }
        if sorted.take(5).join == checkSum
            total += sector
        end
    end
    return total
end

def part2(input)
    total = 0
    for line in input
        values, checkSum = line.split("[")
        checkSum = checkSum.chomp("]")
        letters = values.split("-")
        sector = letters.pop.to_i
        allLetters = letters.join
        counts = {}
        for i in allLetters.split("")
            if not counts[i]
                counts[i] = 0
            end
            counts[i] -= 1
        end
        sorted = counts.keys.sort
        n = 0
        sorted = sorted.map { |a| n += 1; [[counts[a], n], a] }
        sorted = sorted.sort { |a, b| a[0] <=> b[0] }
        sorted = sorted.map { |a| a[1] }
        if sorted.take(5).join == checkSum
            for word in letters
                rotate = sector % 26
                decrypted = word.split("").map { |i| ((i.setbyte(0, i.getbyte(0)) - 97 + sector) % 26 + 97).chr }.join
                print decrypted.downcase
                print " "
            end
            print sector
            puts
        end
    end
    return 0
end

# puts part1(data)
puts part2(data)