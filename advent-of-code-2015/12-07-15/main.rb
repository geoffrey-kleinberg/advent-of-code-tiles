def readIn(file, arr)
  File.open(file) do |f|
    f.each do |i|
      arr << i.strip
    end
  end
  return nil
end

input = []
readIn("input.txt", input)

sinput = []
readIn("samplein.txt", sinput)

def operateValues(operation, signal1, signal2)
  if operation == "AND"
    return signal1 & signal2
  end
  if operation == "OR"
    return signal1 | signal2
  end
  if operation == "LSHIFT"
    return signal1 << signal2
  end
  if operation == "RSHIFT"
     return signal1 >> signal2
  end
end

def part1(input)
  unprocessed = input
  values = {}
  while unprocessed.length != 0
    successful = false
    line = unprocessed[0]
    left, right = line.split(" -> ")
    splitLeft = left.split(" ")
    outputWire = right
    
    if splitLeft.length == 1
      if left.to_i.to_s == left
        values[outputWire] = left.to_i
        successful = true
      elsif values.has_key? left
        values[outputWire] = values[left]
        successful = true
      end
    elsif splitLeft.length == 2
      wire = splitLeft[1]
      if values.has_key? wire
        values[outputWire] = 65535 - values[wire]
        successful = true
      elsif wire.to_i.to_s == wire
        values[outputWire] = 65535 - wire
        successful = true
      end
    else
      operation = splitLeft[1]
      wire1, wire2 = splitLeft[0], splitLeft[2]
      wire1Int = wire1.to_i.to_s == wire1
      wire2Int = wire2.to_i.to_s == wire2
      if values.has_key? wire1 and values.has_key? wire2
        successful = true
        values[outputWire] = operateValues(operation, values[wire1], values[wire2])
      elsif wire1Int and values.has_key? wire2
        successful = true
        values[outputWire] = operateValues(operation, wire1.to_i, values[wire2])
      elsif values.has_key? wire1 and wire2Int
        successful = true
        values[outputWire] = operateValues(operation, values[wire1], wire2.to_i)
      elsif wire1Int and wire2Int
        successful = true
        values[outputWire] = operateValues(operation, wire1.to_i, wire2.to_i)
      end
    end
    if not successful
      unprocessed << line
    end
    unprocessed.delete_at(0)
  end
  return values["a"]
end

def part2(input)
  unprocessed = input
  values = {}
  while unprocessed.length != 0
    successful = false
    line = unprocessed[0]
    left, right = line.split(" -> ")
    splitLeft = left.split(" ")
    outputWire = right
    
    if splitLeft.length == 1
      if left.to_i.to_s == left
        values[outputWire] = left.to_i
        if outputWire == 'b'
          values[outputWire] = 956
        end
        successful = true
      elsif values.has_key? left
        values[outputWire] = values[left]
        successful = true
      end
    elsif splitLeft.length == 2
      wire = splitLeft[1]
      if values.has_key? wire
        values[outputWire] = 65535 - values[wire]
        successful = true
      elsif wire.to_i.to_s == wire
        values[outputWire] = 65535 - wire
        successful = true
      end
    else
      operation = splitLeft[1]
      wire1, wire2 = splitLeft[0], splitLeft[2]
      wire1Int = wire1.to_i.to_s == wire1
      wire2Int = wire2.to_i.to_s == wire2
      if values.has_key? wire1 and values.has_key? wire2
        successful = true
        values[outputWire] = operateValues(operation, values[wire1], values[wire2])
      elsif wire1Int and values.has_key? wire2
        successful = true
        values[outputWire] = operateValues(operation, wire1.to_i, values[wire2])
      elsif values.has_key? wire1 and wire2Int
        successful = true
        values[outputWire] = operateValues(operation, values[wire1], wire2.to_i)
      elsif wire1Int and wire2Int
        successful = true
        values[outputWire] = operateValues(operation, wire1.to_i, wire2.to_i)
      end
    end
    if not successful
      unprocessed << line
    end
    unprocessed.delete_at(0)
  end
  return values["a"]
end

puts part1(sinput.clone)
puts part1(input.clone)

puts

puts part2(sinput.clone)
puts part2(input.clone)