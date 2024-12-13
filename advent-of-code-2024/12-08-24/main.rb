require 'set'

day = "08"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    iMax = input[0].length
    jMax = input[1].length
    antennae = {}
    for row in 0...input.length
      chars = input[row].split("")
      for col in 0...input[row].length
        if chars[col] == "."
          next
        else
          if antennae[chars[col]]
            antennae[chars[col]].append([row, col])
          else
            antennae[chars[col]] = [[row, col]]
          end
        end
      end
    end
    # print antennae
    # puts
    antinode_locs = Set.new()
    for letter in antennae.keys
      locs = antennae[letter]
      for loc1 in 0...locs.length
        for loc2 in (loc1 + 1)...locs.length
          l1 = locs[loc1]
          l2 = locs[loc2]
          delta = [l2[0] - l1[0], l2[1] - l1[1]]
        #   print delta
        #   puts
          possible1 = [l2[0] + delta[0], l2[1] + delta[1]]
          possible2 = [l1[0] - delta[0], l1[1] - delta[1]]

          if possible1[0] >= 0 and possible1[0] < iMax and possible1[1] >= 0 and possible1[1] < jMax
            antinode_locs.add(possible1)
          end
          if possible2[0] >= 0 and possible2[0] < iMax and possible2[1] >= 0 and possible2[1] < jMax
            antinode_locs.add(possible2)
          end
        end
      end
    end
    # print antinode_locs
    # puts
    return antinode_locs.size
end

def part2(input)
    iMax = input[0].length
    jMax = input[1].length
    antennae = {}
    for row in 0...input.length
      chars = input[row].split("")
      for col in 0...input[row].length
        if chars[col] == "."
          next
        else
          if antennae[chars[col]]
            antennae[chars[col]].append([row, col])
          else
            antennae[chars[col]] = [[row, col]]
          end
        end
      end
    end
    # print antennae
    # puts
    antinode_locs = Set.new()
    for letter in antennae.keys
      locs = antennae[letter]
      for loc1 in 0...locs.length
        for loc2 in (loc1 + 1)...locs.length
          l1 = locs[loc1]
          l2 = locs[loc2]
          antinode_locs.add(l1)
          antinode_locs.add(l2)
          delta = [l2[0] - l1[0], l2[1] - l1[1]]
        #   print delta
        #   puts
          possible1 = [l2[0] + delta[0], l2[1] + delta[1]]
          while possible1[0] >= 0 and possible1[0] < iMax and possible1[1] >= 0 and possible1[1] < jMax
            antinode_locs.add(possible1)
            possible1 = [possible1[0] + delta[0], possible1[1] + delta[1]]
          end
          possible2 = [l1[0] - delta[0], l1[1] - delta[1]]
          while possible2[0] >= 0 and possible2[0] < iMax and possible2[1] >= 0 and possible2[1] < jMax
            antinode_locs.add(possible2)
            possible2 = [possible2[0] - delta[0], possible2[1] - delta[1]]
          end
        end
      end
    end
    for i in 0...iMax
      for j in 0...jMax
        if antinode_locs.include? [i, j]
          print "#"
        else
          print "."
        end
      end
      puts
    end
    # print antinode_locs
    # puts
    return antinode_locs.size
end

# puts part1(data)
puts part2(data)