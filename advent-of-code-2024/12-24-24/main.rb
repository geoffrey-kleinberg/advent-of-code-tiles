require 'set'

day = "24"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/fixed.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    known = {
    }
    todo = []

    val = true
    for line in input
      if line == ""
        val = false
        next
      end
      if val
        key, num = line.split(": ")
        num = num.to_i
        known[key] = num
      else
        todo.append(line.split(" "))
      end
    end

    idx = 0

    while todo.length > 0
      cur = todo[idx]

      v1, v2 = cur[0], cur[2]
      op = cur[1]
      out = cur[4]

      if known[v1] and known[v2]
        if op == "AND"
          known[out] = known[v1] & known[v2]
        elsif op == "OR"
            known[out] = known[v1] | known[v2]
        elsif op == "XOR"
            known[out] = known[v1] ^ known[v2]
        end
        todo.delete_at(idx)
      end

      if idx <= todo.length - 2
        idx += 1
      else
        idx = 0
      end
    end

    zKeys = known.keys.filter { |i| i[0] == "z" }
    zMax = zKeys.max { |i, j| i[1..].to_i <=> j[1..].to_i }[1..].to_i
    val = 0
    for i in 0..zMax
      str = i.to_s
      while str.length < 2
        str = "0" + str
      end
      if known["z" + str] == 1
        val += 2 ** i
      end
    end
    return val
end

# HOW ADDITION WORKS
# x00 XOR y00 -> z00
# 
# x00 AND y00 -> qkm (carry)
# 
# x01 XOR y01 -> rvb
# x01 AND y01 -> svq (carry1)
# 
# qkm XOR rvb -> z01
# qkm AND rvb -> ksr (carry2)
# 
# ksr OR svq -> qfj (carry)
# 
# errors (fixed manually, changes made in fixed.txt)
# 
# carry is trt
# x27 XOR y27 -> nfj
# x27 AND y27 -> ncd
# 
# nfj XOR trt -> z27
# nfj AND trt -> hrn
# 
# hrn OR ncd -> ndd (carry)
# 
#
# carry is fcm
# x37 XOR y37 -> dnt 
# x37 AND y37 -> jbg (c1)
# 
# dnt XOR fcm -> vkg
# fcm AND dnt -> z37
# 

def part2(input)
    known = {}
    comesFrom = {}
    xors = {}
    ands = {}
    ors = {}

    val = true
    for line in input
      if line == ""
        val = false
        next
      end
      if val
        key, num = line.split(": ")
        num = num.to_i
        known[key] = num
      else
        spl = line.split(" ")
        comesFrom[spl[4]] = [spl[0], spl[2]]
        if spl[1] == "XOR"
          xors[Set[spl[0], spl[2]]] = spl[4]
        elsif spl[1] == "OR"
          ors[Set[spl[0], spl[2]]] = spl[4]
        elsif spl[1] == "AND"
          ands[Set[spl[0], spl[2]]] = spl[4]
        end
      end
    end

    carrys = ["qkm"]

    for z in 1..45
        str = z.to_s
        while str.length < 2
          str = "0" + str
        end
        zstr = "z" + str
        xstr = "x" + str
        ystr = "y" + str

        xorstr = xors[Set[xstr, ystr]]

        c1 = ands[Set[xstr, ystr]]
        c2 = ands[Set[xorstr, carrys[z-1]]]

        if not ands[Set[xorstr, carrys[z-1]]]
          puts xorstr, carrys[z-1]
          raise "and error"
        end

        if not ors[Set[c1, c2]]
          puts c1, c2, z
          raise "or error"
        end

        if not xors[Set[xorstr, carrys[z-1]]] == zstr
          puts xorstr
          puts carrys[z-1]
          puts z
          raise "xor error"
        end


        carrys.append(ors[Set[c1, c2]])
    end

end

# puts part1(data)
puts part2(data)