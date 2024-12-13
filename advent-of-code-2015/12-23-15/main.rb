lines = []
file = "input.txt"
#file = "samplein.txt"
File.open(file) do |f|
  f.each do |line|
    lines << line.rstrip
  end
end

def part1(input)
  vals = {
    "a" => 0,
    "b" => 0
  }
  instructions = input.map { |i| i.split(" ")}
  cur = 0
  while cur < instructions.length
    i = instructions[cur]
    var = i[1].chomp(",")
    if i[0] == "hlf"
      vals[var] /= 2
      cur += 1
    elsif i[0] == "tpl"
      vals[var] *= 3
      cur += 1
    elsif i[0] == "inc"
      vals[var] += 1
      cur += 1
    elsif i[0] == "jmp"
      cur += var.to_i
    elsif i[0] == "jie"
      if vals[var] % 2 == 0
        cur += i[2].to_i
      else
        cur += 1
      end
    elsif i[0] == "jio"
      if vals[var] == 1
        cur += i[2].to_i
      else
        cur += 1
      end
    else
      raise 'balls'
    end
  end
  puts vals["a"]
  return vals["b"]
end

def part2(input)
  vals = {
    "a" => 1,
    "b" => 0
  }
  instructions = input.map { |i| i.split(" ")}
  cur = 0
  while cur < instructions.length
    i = instructions[cur]
    var = i[1].chomp(",")
    if i[0] == "hlf"
      vals[var] /= 2
      cur += 1
    elsif i[0] == "tpl"
      vals[var] *= 3
      cur += 1
    elsif i[0] == "inc"
      vals[var] += 1
      cur += 1
    elsif i[0] == "jmp"
      cur += var.to_i
    elsif i[0] == "jie"
      if vals[var] % 2 == 0
        cur += i[2].to_i
      else
        cur += 1
      end
    elsif i[0] == "jio"
      if vals[var] == 1
        cur += i[2].to_i
      else
        cur += 1
      end
    else
      raise 'balls'
    end
  end
  puts vals["a"]
  return vals["b"]
end

puts part1(lines)
puts part2(lines)