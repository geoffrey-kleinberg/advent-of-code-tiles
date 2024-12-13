require 'set'

day = "15"
file_name = "12-#{day}-16/sampleIn.txt"
file_name = "12-#{day}-16/input.txt"

# 176737 too high

data = File.read(file_name).split("\n").map { |i| i.strip }

def getBezoutCoefs(x, y)
  r0 = x
  r1 = y
  s0 = 1
  s1 = 0
  t0 = 0
  t1 = 1

  while r0 % r1 != 0
    q = r0 / r1

    nextR = r0 % r1
    nextS = s0 - q * s1
    nextT = t0 - q * t1

    r0, r1 = r1, nextR
    s0, s1 = s1, nextS
    t0, t1 = t1, nextT
  end

  return s1, t1
end

def crt(nums)
  
end

def part1(input)
  nums = []
  for line in input
    nums.append([])
    spl = line.split(" ")
    nums[-1].append(spl[1].slice(-1).to_i * -1)
    nums[-1].append(spl[3].to_i)
    nums[-1][0] -= spl[-1].slice(0).to_i
    nums[-1][0] %= nums[-1][1]
  end
  n1 = nums[0][1]
  r1 = nums[0][0]
  for i in 1...nums.length
    r2, n2 = nums[i]
    m1, m2 = getBezoutCoefs(n1, n2)
    x = r1 * m2 * n2 + r2 * m1 * n1
    n1 = n1 * n2
    r1 = x % n1
  end
  return r1
end

def part2(input)
  nums = []
  for line in input
    nums.append([])
    spl = line.split(" ")
    nums[-1].append(spl[1].slice(-1).to_i * -1)
    nums[-1].append(spl[3].to_i)
    nums[-1][0] -= spl[-1].slice(0).to_i
    nums[-1][0] %= nums[-1][1]
  end
  nums.append([-7 % 11, 11])
  n1 = nums[0][1]
  r1 = nums[0][0]
  for i in 1...nums.length
    r2, n2 = nums[i]
    m1, m2 = getBezoutCoefs(n1, n2)
    x = r1 * m2 * n2 + r2 * m1 * n1
    n1 = n1 * n2
    r1 = x % n1
  end
  return r1
end

puts part1(data)
puts part2(data)