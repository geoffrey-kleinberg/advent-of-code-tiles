require 'set'

day = "21"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input, string="abcdefgh")
  # string = "abcde"
  string = "afhdbegc"

  string = string.split("")

  for line in input
    sep = line.split(" ")
    if sep[0] == "swap"
      if sep[1] == "position"
        l1, l2 = sep[2].to_i, sep[-1].to_i
        string[l1], string[l2] = string[l2], string[l1]
      else
        l1, l2 = sep[2], sep[-1]
        i1 = string.index(l1)
        i2 = string.index(l2)
        string[i1] = l2
        string[i2] = l1
      end
    elsif sep[0] == "rotate"
      if sep[1] == "right"
        string = string.rotate(-1 * sep[2].to_i)
      elsif sep[1] == "left"
        string = string.rotate(sep[2].to_i)
      elsif sep[1] == "based"
        letter = sep[-1]
        val = string.index(letter)
        add = (val >= 4) ? 1 : 0
        string = string.rotate(-1 - val - add)
      end
    elsif sep[0] == "reverse"
      p1, p2 = sep[2].to_i, sep[4].to_i
      string = string[0...p1] + string[p1..p2].reverse + string[(p2 + 1)...]
    elsif sep[0] == "move"
      p1, p2 = sep[2].to_i, sep[5].to_i
      letter = string.delete_at(p1)
      string.insert(p2, letter)
    end
    # puts line
    # puts string.join
  end

  return string.join
end

def part2(input)
  # string = "fbgdceah"
  # string = "decab"
  


end

def part2bf(input)
  ["a", "b", "c", "d", "e", "f", "g", "h"].permutation(8).each do |string|
    if part1(input, string.join) == "fbgdceah"
      return string.join
    end
  end
end

# puts part1(data)
puts part2bf(data)