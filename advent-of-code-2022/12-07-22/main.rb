fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def navigate(cur, cmd)
  parts = cmd.split(" ")
  if parts[2] == "/"
    return "/"
  elsif parts[2] == ".."
    cur.split
    return (cur.split("/").slice(0, cur.split("/").length - 1).join("/")) + "/"
  else
    return cur + parts[2] + "/"
  end
end

def process(elements)
  toReturn = []
  for i in elements
    parts = i.split(" ")
    if parts[0] == "dir"
      toReturn.append([parts[1], -1])
    else
      toReturn.append([parts[1], parts[0].to_i])
    end
  end
  return toReturn
end


def getMap(input)
  curDir = ""
  elements = []
  adding = false
  tree = {}
  for i in input
    if i.slice(0, 4) == "$ cd"
      adding = false
      subTree = process(elements.clone)
      tree[curDir] = subTree if not tree[curDir]
      curDir = navigate(curDir, i)
    elsif i.slice(0, 4) == "$ ls"
      elements = []
      adding = true
    elsif adding
      elements << i
    end
  end
  tree[curDir] = process(elements)
  return tree
end

def getSize(node, tree)
  size = 0
  for i in tree[node]
    if i[1] == -1
      size += getSize(node + i[0] + "/", tree)
    else
      size += i[1]
    end
  end
  return size
end

def getSizes(tree)
  sizes = {}
  for i in tree.keys
    sizes[i] = getSize(i, tree)
  end 
  return sizes
end

def part1(input)
  tree = getMap(input)
  sizes = getSizes(tree)
  #print sizes
  return sizes.values.sum { |i| (i < 100000) ? i : 0 }
end

def part2(input)
  tree = getMap(input)
  sizes = getSizes(tree)
  totalSize = 70000000
  remaining = totalSize - sizes["/"]
  goal = 30000000
  for i in sizes.values.sort
    if i + remaining > goal
      return i
    end
  end
end

puts part1(data)
puts part2(data)