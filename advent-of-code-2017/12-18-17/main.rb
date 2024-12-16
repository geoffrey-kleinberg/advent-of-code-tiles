require 'set'

day = "18"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    regs = {

    }
    regs.default = 0
    letters = ('a'..'z').to_a


    line = 0
    lastSound = nil
    while line < input.length
      inst = input[line].split(" ")
      v1 = inst[1]
      if letters.include? v1
        v1 = regs[v1]
      end
      v1 = v1.to_i
      v2 = inst[2]
      if letters.include? v2
        v2 = regs[v2]
      end
      v2 = v2.to_i
      if inst[0] == "snd"
        lastSound = v1
        line += 1
      elsif inst[0] == "set"
        regs[inst[1]] = v2.to_i
        line += 1
      elsif inst[0] == "add"
        regs[inst[1]] += v2
        line += 1
      elsif inst[0] == "mul"
        regs[inst[1]] *= v2
        line += 1
      elsif inst[0] == "mod"
        regs[inst[1]] %= v2
        line += 1
      elsif inst[0] == "rcv"
        if v1 != 0
          return lastSound
        end
        line += 1
      elsif inst[0] == "jgz"
        if v1 > 0
          line += v2
        else
          line += 1
        end
      end
    end
end

def runLine(l, line, regs, letters, otherQueue)
    inst = l.split(" ")
    v1 = inst[1]
    if letters.include? v1
      v1 = regs[v1]
    end
    v1 = v1.to_i
    v2 = inst[2]
    if letters.include? v2
      v2 = regs[v2]
    end
    v2 = v2.to_i
    if inst[0] == "snd"
      line += 1
      return [line, v1]
    elsif inst[0] == "set"
      regs[inst[1]] = v2.to_i
      line += 1
    elsif inst[0] == "add"
      regs[inst[1]] += v2
      line += 1
    elsif inst[0] == "mul"
      regs[inst[1]] *= v2
      line += 1
    elsif inst[0] == "mod"
      regs[inst[1]] %= v2
      line += 1
    elsif inst[0] == "rcv"
      # logic in here, line shouldn't increase until we recieve
      if otherQueue.length == 0
        return [line, "waiting"]
      else
        val = otherQueue.shift
        regs[inst[1]] = val
        line += 1
        return [line, nil]
      end
    elsif inst[0] == "jgz"
      if v1 > 0
        line += v2
      else
        line += 1
      end
    end
    return [line, nil]
end

def part2(input)
    reg0 = {
        "p" => 0
    }
    reg0.default = 0
    reg1 = {
        "p" => 1
    }
    reg1.default = 0
    letters = ('a'..'z').to_a

    p1Line = 0
    p0Line = 0
    p1Queue = []
    p0Queue = []
    p1Waiting = false
    p0Waiting = false
    p1Sent = 0

    p1Result = nil
    p0Result = nil

    while true
      if p1Waiting and p0Waiting
        return p1Sent
      end
    
      if (not p0Waiting) or (p0Waiting and p1Queue.length > 0)
        p0Result = runLine(input[p0Line], p0Line, reg0, letters, p1Queue)
        p0Line = p0Result[0]
        if not p0Result[1]
        elsif p0Result[1] == "waiting"
            p0Waiting = true
        else
            p0Queue.append(p0Result[1])
        end
      end

      if (not p1Waiting) or (p1Waiting and p0Queue.length > 0)
        p1Result = runLine(input[p1Line], p1Line, reg1, letters, p0Queue)
        p1Line = p1Result[0]
        if not p1Result[1]
        elsif p1Result[1] == "waiting"
            p1Waiting = true
        else
            p1Sent += 1
            p1Queue.append(p1Result[1])
        end
      end

    end
end

# puts part1(data)
puts part2(data)