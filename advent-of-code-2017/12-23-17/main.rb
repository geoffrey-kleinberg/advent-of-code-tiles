require 'set'

day = "23"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

# 3025 is too high

def part1(input)
    register = {}
    register.default = 0

    vars = ('a'..'h').to_a
    mults = 0

    index = 0

    while index < input.length
      spl = input[index].split(" ")
      v1 = spl[1]
      if vars.include? v1
        v1 = register[v1].to_i
      else
        v1 = v1.to_i
      end
      v2 = spl[2]
      if vars.include? v2
        v2 = register[v2].to_i
      else
        v2 = v2.to_i
      end
      if spl[0] == "set"
        register[spl[1]] = v2
        index += 1
      elsif spl[0] == "mul"
        register[spl[1]] = v1 * v2
        mults += 1
        index += 1
      elsif spl[0] == "sub"
        register[spl[1]] = v1 - v2
        index += 1
      elsif spl[0] == "jnz"
        if v1 != 0
          index += v2
        else
          index += 1
        end
      end
    end

    return mults
end

def isPrime(n)
  highest = Math.sqrt(n).ceil
  for i in 2..highest
    if n % i == 0
      return false
    end
  end
  return true
end

def part2(input)
    # h increases when b is prime
    # b goes from 105700 to 122700, increasing by 17s
    nonPrimes = 0
    b = 57 * 100 + 100000
    while b <= 57 * 100 + 100000 + 17000
      if not isPrime(b)
        nonPrimes += 1
      end
      b += 17
    end
    return nonPrimes
end

puts part1(data)
puts part2(data)