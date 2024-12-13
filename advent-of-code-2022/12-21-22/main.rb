require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def calc(monkey, ops, vals, part2)
  if monkey == 'humn' and part2
    return false
  end
  if vals[monkey]
    return vals[monkey]
  end
  m1 = ops[monkey][0]
  m2 = ops[monkey][1]
  if [m1, m2].include? 'humn' and part2
    return false
  end
  val1 = 0
  val2 = 0
  if vals[m1]
    val1 = vals[m1]
  else
    val1 = calc(m1, ops, vals, part2)
    return val1 if not val1
  end
  if vals[m2]
    val2 = vals[m2]
  else
    val2 = calc(m2, ops, vals, part2)
    return val2 if not val2
  end
  op = ops[monkey][2]
  if op == "+"
    vals[monkey] = val1 + val2
    return val1 + val2
  elsif op == "-"
    vals[monkey] = val1 - val2
    return val1 - val2
  elsif op == "*"
    vals[monkey] = val1 * val2
    return val1 * val2
  else
    vals[monkey] = val1 / val2
    return val1 / val2
  end
  raise 'a'
end

def part1(input)
  vals = {}
  ops = {}
  for i in input
    parts = i.split(": ")
    if parts[1].split("").all? { |j| "0123456789".include? j }
      vals[parts[0]] = parts[1].to_i
    else
      diff = parts[1].split(" ")
      ops[parts[0]] = [diff[0], diff[2], diff[1]]
    end
  end
  return calc("root", ops, vals, false)
end

def part2(input)
  vals = {}
  ops = {}
  for i in input
    parts = i.split(": ")
    if parts[1].split("").all? { |j| "0123456789".include? j }
      vals[parts[0]] = parts[1].to_i
    else
      diff = parts[1].split(" ")
      ops[parts[0]] = [diff[0], diff[2], diff[1]]
    end
  end
  tVal = 396900
  while true
    testVals = vals.clone
    testVals['humn'] = tVal
    s1 = ops['root'][0]
    s2 = ops['root'][1]
    s1Val = calc(s1, ops, testVals, true)
    s2Val = calc(s2, ops, testVals, true)
    if s1Val == s2Val
      return tVal
    end
    tVal += 1
    puts tVal if tVal % 100 == 0
  end
  return 0
end

def getUnknownChild(root, tree, ops, vals)
  a = calc(tree[root][0], ops, vals, true)
  return a ? tree[root][1] : tree[root][0]
end

def getKnownChild(root, tree, ops, vals)
  a = calc(tree[root][0], ops, vals, true)
  return a ? tree[root][0] : tree[root][1]
end

def better2(input)
  used = Set[]
  tree = {}
  parents = {}
 #curr = 'root'
  vals = {}
  ops = {}
  #unUsed = []
  for i in input
    parts = i.split(": ")
    if parts[1].split("").all? { |j| "0123456789".include? j }
      vals[parts[0]] = parts[1].to_i
    else
      diff = parts[1].split(" ")
      ops[parts[0]] = [diff[0], diff[2], diff[1]]
    end
    #unUsed << parts[0]
  end
  ops['root'][2] = '='
  queue = ['root']
  while queue.length > 0
    curr = queue[0]
    if not used.add? curr
      print used
      puts curr
      raise 'oi'
    end
    if vals.keys.include? curr
      tree[curr] = vals[curr]
    else
      tree[curr] = ops[curr]
      parents[ops[curr][0]] = curr
      parents[ops[curr][1]] = curr
      queue.append(ops[curr][0])
      queue.append(ops[curr][1])
    end
    queue.delete_at(0)
  end
  #puts tree
  # node = 'root'
#   knownChild = getKnownChild(node, tree, ops, vals)
#   unknownChild = getUnknownChild(node, tree, ops, vals)
#   reg = calc(knownChild, ops, vals)
#   node = unknownChild
#   knownChild = getKnownChild(node, tree, ops, vals)
#   unknownChild = getUnknownChild(node, tree, ops, vals)
#   reg = reg - calc(knownChild, ops, vals)
#   node = unknownChild
#   knownChild = getKnownChild(node, tree, ops, vals)
#   unknownChild = getUnknownChild(node, tree, ops, vals)
#   reg = reg + calc(knownChild, ops, vals)
#   break #because unknownChild = 'humn' and return reg
  node = 'root'
  reg = -1
  while node != 'humn'
    #puts node
    knownChild = getKnownChild(node, tree, ops, vals)
    unknownChild = getUnknownChild(node, tree, ops, vals)
    #puts knownChild
    #puts unknownChild
    #puts
    if ops[node][2] == '='
      reg = calc(knownChild, ops, vals, true)
    elsif ops[node][2] == '+'
      reg = reg - calc(knownChild, ops, vals, true)
    elsif ops[node][2] == '*'
      reg = reg / calc(knownChild, ops, vals, true)
    elsif ops[node][2] == '-'
      if unknownChild != ops[node][0]
        reg = calc(knownChild, ops, vals, true) -  reg
      else
        reg = reg + calc(knownChild, ops, vals, true)
      end
    else
      if unknownChild != ops[node][0]
        raise 'something'
      else
        reg = reg * calc(knownChild, ops, vals, true)
      end
    end
    node = unknownChild
  end
  return reg
  # node = 'root'
#   children = tree[node].first(2)
#   op = tree[node][2]
#   unknownChild = getUnknownChild(node, tree, ops, vals)
#   knownChild = getKnownChild(node, tree, ops, vals)
#   goalUnknown = -1
#   thisVal = calc(knownChild, ops, vals)
#   if op == '='
#     goalUnknown = thisVal
#   elsif op == '+'
#     goalUnknown = thisVal

  
  
end

t = Time.now
puts part1(data)
puts Time.now - t
t = Time.now
puts better2(data)
puts Time.now - t