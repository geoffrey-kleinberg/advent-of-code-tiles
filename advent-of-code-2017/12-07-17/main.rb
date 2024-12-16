require 'set'

day = "07"
file_name = "12-#{day}-17/sampleIn.txt"
file_name = "12-#{day}-17/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    tree = {}
    sizes = {}

    supported = Set[]
    allIds = Set[]

    for line in input
      spl = line.split(" ")
      id = spl[0]
      allIds.add(id)
      size = spl[1][1...-1].to_i
      sizes[id] = size
      if spl.length > 2
        remainder = spl[3..].map { |i| i.chomp(",") }
        tree[id] = remainder
        supported += remainder
      end
    end

    
    return (allIds - supported).to_a[0]
end

def getWeightAbove(base, tree, sizes, weightsAbove)
  above = tree[base]
  weight = sizes[base]
  for i in above
    if tree[i]
      weight += getWeightAbove(i, tree, sizes, weightsAbove)
    else
      weight += sizes[i]
      weightsAbove[i] = sizes[i]
    end
  end
  weightsAbove[base] = weight
end

def part2(input)
    tree = {}
    sizes = {}

    supported = Set[]
    allIds = Set[]

    for line in input
      spl = line.split(" ")
      id = spl[0]
      allIds.add(id)
      size = spl[1][1...-1].to_i
      sizes[id] = size
      if spl.length > 2
        remainder = spl[3..].map { |i| i.chomp(",") }
        tree[id] = remainder
        supported += remainder
      end
    end

    
    base = (allIds - supported).to_a[0]
    
    weightsAbove = {}

    getWeightAbove(base, tree, sizes, weightsAbove)

    treeWeights = {}
    for i in tree.keys
      treeWeights[i] = {}
      for j in tree[i]
        treeWeights[i][j] = weightsAbove[j]
      end
    end

    unbalanced = treeWeights.filter do |k, v|
      v.values.uniq.length != 1
    end

    wrong = base

    while unbalanced[wrong]
      vals = unbalanced[wrong].values.uniq
      off = (unbalanced[wrong].values.count(vals[0]) == 1) ? vals[0] : vals[1]
      mode = (off == vals[0]) ? vals[1] : vals[0]
      wrong = unbalanced[wrong].select { |k, v| v == off }.keys[0]
    end

    return sizes[wrong] - (off - mode)
end

# puts part1(data)
puts part2(data)