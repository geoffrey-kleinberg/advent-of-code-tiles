require 'set'

day = "25"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)

    lockHeights = []
    keyHeights = []

    input.each_slice(8) do |i|
      i = i[0...7].map { |j| j.split("")}
      if i[0].all? { |char| char == "#" }
        toAdd = []
        for l in 0...8
            line = i[l]
            for j in 0...5
                if not toAdd[j] and line[j] == "."
                    toAdd[j] = l - 1
                end
            end
        end
        lockHeights.append(toAdd)
      else
        i = i.reverse
        toAdd = []
        for l in 0...8
          line = i[l]
        #   p line
          for j in 0...5
            if not toAdd[j] and line[j] == "."
              toAdd[j] = l - 1
            end
          end
        end
        # puts
        keyHeights.append(toAdd)
      end
    end

    count = 0
    for i in lockHeights
      for j in keyHeights
        valid = true
        for k in 0...5
          if i[k] + j[k] >= 6
            valid = false
            break
          end
        end
        if valid
          count += 1
        end
      end
    end

    return count
end

puts part1(data)