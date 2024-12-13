require 'set'

day = "10"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    botHas = {}
    botGives = {}

    hasTwo = []

    for line in input
      if line.index('value') == 0
        sep = line.split(" ")
        val = sep[1].to_i
        botNum = sep[-1]
        if not botHas['b' + botNum]
          botHas['b' + botNum] = []
        end
        botHas['b' + botNum].append(val)
        if botHas['b' + botNum].length == 2
          hasTwo.append('b' + botNum)
        end
      else
        sep = line.split(" ")
        botNum = sep[1]
        lowT, lowN = sep[5..6]
        if lowT == 'output'
          lowT = 'o'
        else
          lowT = 'b'
        end
        highT, highN = sep[10..11]
        if highT == 'output'
          highT = 'o'
        else
          highT = 'b'
        end
        botGives['b' + botNum] = [lowT + lowN, highT + highN]
      end
    end

    remaining = hasTwo.clone

    while remaining.length > 0
      cur = remaining[0]
      
      lowTo, highTo = botGives[cur]
      min, max = botHas[cur].min, botHas[cur].max

      if min == 17 and max == 61
        return cur.slice(1..-1)
      end

      if not botHas[lowTo]
        botHas[lowTo] = []
      end
      if not botHas[highTo]
        botHas[highTo] = []
      end

      botHas[lowTo].append(min)
      botHas[highTo].append(max)

      if botHas[lowTo].length == 2 and lowTo.slice(0) == 'b'
        remaining.append(lowTo)
      end
      if botHas[highTo].length == 2 and highTo.slice(0) == 'b'
        remaining.append(highTo)
      end

      remaining.delete_at(0)
    end

    return nil
end

def part2(input)
  botHas = {}
  botGives = {}

  hasTwo = []

  for line in input
    if line.index('value') == 0
      sep = line.split(" ")
      val = sep[1].to_i
      botNum = sep[-1]
      if not botHas['b' + botNum]
        botHas['b' + botNum] = []
      end
      botHas['b' + botNum].append(val)
      if botHas['b' + botNum].length == 2
        hasTwo.append('b' + botNum)
      end
    else
      sep = line.split(" ")
      botNum = sep[1]
      lowT, lowN = sep[5..6]
      if lowT == 'output'
        lowT = 'o'
      else
        lowT = 'b'
      end
      highT, highN = sep[10..11]
      if highT == 'output'
        highT = 'o'
      else
        highT = 'b'
      end
      botGives['b' + botNum] = [lowT + lowN, highT + highN]
    end
  end

  remaining = hasTwo.clone

  while remaining.length > 0
    cur = remaining[0]
    
    lowTo, highTo = botGives[cur]
    min, max = botHas[cur].min, botHas[cur].max

    if not botHas[lowTo]
      botHas[lowTo] = []
    end
    if not botHas[highTo]
      botHas[highTo] = []
    end

    botHas[lowTo].append(min)
    botHas[highTo].append(max)

    if botHas[lowTo].length == 2 and lowTo.slice(0) == 'b'
      remaining.append(lowTo)
    end
    if botHas[highTo].length == 2 and highTo.slice(0) == 'b'
      remaining.append(highTo)
    end

    remaining.delete_at(0)
  end

  return botHas['o0'][0] * botHas['o1'][0] * botHas['o2'][0]
end

# puts part1(data)
puts part2(data)