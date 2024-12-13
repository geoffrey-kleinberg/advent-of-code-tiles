require 'set'

day = "13"
file_name = "12-#{day}-24/sampleIn.txt"
file_name = "12-#{day}-24/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    lineSets = []
    for i in 0...input.length
      if i % 4 == 0
        lineSets.append([])
      end
      if i % 4 != 3
        lineSets[-1].append(input[i])
      end
    end

    cost = 0

    for l in lineSets
      matrix = [[], []]
      a1, a2 = l[0].split(" ")[2..3].map { |i| i.split("+")[1].chomp(",").to_f }
      b1, b2 = l[1].split(" ")[2..3].map { |i| i.split("+")[1].chomp(",").to_f }
      matrix[0][0] = a1
      matrix[0][1] = b1
      matrix[1][0] = a2
      matrix[1][1] = b2

      target = l[2].split(" ")[1..2].map { |i| i.split("=")[1].chomp(",").to_f }

      coef1 = matrix[0][0] / matrix[1][0]

      matrix[1] = matrix[1].map { |i| i * coef1 }
      target[1] *= coef1

      b = (target[0] - target[1]) / (matrix[0][1] - matrix[1][1])
      a = (target[0] - matrix[0][1] * b) / matrix[0][0]

      if a.round == a.round(8) and b.round == b.round(8) and a <= 100 and b <= 100
        cost += 3 * a + b
      end
    end

    return cost.to_i
end

def part2(input)
    lineSets = []
    for i in 0...input.length
      if i % 4 == 0
        lineSets.append([])
      end
      if i % 4 != 3
        lineSets[-1].append(input[i])
      end
    end

    cost = 0

    for l in lineSets
      matrix = [[], []]
      a1, a2 = l[0].split(" ")[2..3].map { |i| i.split("+")[1].chomp(",").to_i }
      b1, b2 = l[1].split(" ")[2..3].map { |i| i.split("+")[1].chomp(",").to_i }
      matrix[0][0] = a1
      matrix[0][1] = b1
      matrix[1][0] = a2
      matrix[1][1] = b2

      target = l[2].split(" ")[1..2].map { |i| i.split("=")[1].chomp(",").to_i }

      target[0] += 10000000000000
      target[1] += 10000000000000

      coef1 = matrix[0][0]
      coef0 = matrix[1][0]

      matrix[1] = matrix[1].map { |i| i * coef1 }
      matrix[0] = matrix[0].map { |i| i * coef0 }
      target[1] *= coef1
      target[0] *= coef0

      next if not (target[0] - target[1]) % (matrix[0][1] - matrix[1][1]) == 0
      b = (target[0] - target[1]) / (matrix[0][1] - matrix[1][1])

      next if not (target[0] - matrix[0][1] * b) % matrix[0][0] == 0
      a = (target[0] - matrix[0][1] * b) / matrix[0][0]

      cost += 3*a + b
    end

    return cost.to_i
end

# puts part1(data)
puts part2(data)