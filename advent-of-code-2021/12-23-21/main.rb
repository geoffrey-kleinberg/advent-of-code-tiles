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

def anythingBetween(arr, loc, goal)
  if goal == "A"
    if loc > 2
      for i in 2...loc
        if arr[i]
          return true
        end
      end
    elsif loc < 1
      for i in (loc + 1)..1
        if arr[i]
          return true
        end
      end
    end
  elsif goal == "B"
    if loc > 3
      for i in 3...loc
        if arr[i]
          return true
        end
      end
    elsif loc < 2
      for i in (loc + 1)..2
        if arr[i]
          return true
        end
      end
    end
  elsif goal == "C"
    if loc > 4
      for i in 4...loc
        if arr[i]
          return true
        end
      end
    elsif loc < 3
      for i in (loc + 1)..3
        if arr[i]
          return true
        end
      end
    end
  elsif goal == "D"
    if loc > 5
      for i in 5...loc
        if arr[i]
          return true
        end
      end
    elsif loc < 4
      for i in (loc + 1)..4
        if arr[i]
          return true
        end
      end
    end
  end
  return false
end

def getAllPossibleNext(location)
  #returns a hash of possible states mapped
  #to the cost to get to that state
  energyCosts = {
    "A" => 1,
    "B" => 10,
    "C" => 100,
    "D" => 1000
  }
  right = {
    7 => "A",
    8 => "B",
    9 => "C",
    10 => "D"
  }
  distances = {
    [0, 7] => 3,
    [1, 7] => 2,
    [2, 7] => 2,
    [3, 7] => 4,
    [4, 7] => 6,
    [5, 7] => 8,
    [6, 7] => 9,
    [0, 8] => 5,
    [1, 8] => 4,
    [2, 8] => 2,
    [3, 8] => 2,
    [4, 8] => 4,
    [5, 8] => 6,
    [6, 8] => 7,
    [0, 9] => 7,
    [1, 9] => 6,
    [2, 9] => 4,
    [3, 9] => 2,
    [4, 9] => 2,
    [5, 9] => 4,
    [6, 9] => 5,
    [0, 10] => 9,
    [1, 10] => 8,
    [2, 10] => 6,
    [3, 10] => 4,
    [4, 10] => 2,
    [5, 10] => 2,
    [6, 10] => 3,
    [0, 11] => 4,
    [1, 11] => 3,
    [2, 11] => 3,
    [3, 11] => 5,
    [4, 11] => 7,
    [5, 11] => 9,
    [6, 11] => 10,
    [0, 12] => 6,
    [1, 12] => 5,
    [2, 12] => 3,
    [3, 12] => 3,
    [4, 12] => 5,
    [5, 12] => 7,
    [6, 12] => 8,
    [0, 13] => 8,
    [1, 13] => 7,
    [2, 13] => 5,
    [3, 13] => 3,
    [4, 13] => 3,
    [5, 13] => 5,
    [6, 13] => 6,
    [0, 14] => 10,
    [1, 14] => 9,
    [2, 14] => 7,
    [3, 14] => 5,
    [4, 14] => 3,
    [5, 14] => 3,
    [6, 14] => 4,
  }
  possible = {}
  for i in 7...11
    next if not location[i]
    next if location[i] == location[i + 4] and location[i] == right[i]
    for j in 0...7
      next if anythingBetween(location, j, right[i])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        if distances[[i, j]]
          possible[check] = distances[[i, j]] * energyCosts[check[j]]
        else
          possible[check] = distances[[j, i]] * energyCosts[check[j]]
        end
      end
    end
  end
  for i in 11...15
    next if not location[i]
    next if location[i] == right[i - 4]
    next if location[i] == location[i - 4] and location[i] == right[i - 4]
    next if location[i - 4]
    for j in 0...7
      next if anythingBetween(location, j, right[i - 4])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        if distances[[i, j]]
          possible[check] = distances[[i, j]] * energyCosts[check[j]]
        else
          possible[check] = distances[[j, i]] * energyCosts[check[j]]
        end
      end
    end
  end
  for i in 0...7
    next if not location[i]
    if location[i] == "A"
      next if [location[7], location[11]].any? { |val|
        val and val != "A"
      }
      next if anythingBetween(location, i, "A")
      if location[11]
        check = location.clone
        check[7] = "A"
        check[i] = nil
        if distances[[i, 7]]
          possible[check] = distances[[i, 7]]
        else
          possible[check] = distances[[7, i]]
        end
      else
        check = location.clone
        check[11] = "A"
        check[i] = nil
        if distances[[i, 11]]
          possible[check] = distances[[i, 11]]
        else
          possible[check] = distances[[11, i]]
        end
      end
    elsif location[i] == "B"
      next if [location[8], location[12]].any? { |val|
        val and val != "B"
      }
      next if anythingBetween(location, i, "B")
      if location[12]
        check = location.clone
        check[8] = "B"
        check[i] = nil
        if distances[[i, 8]]
          possible[check] = distances[[i, 8]] * 10
        else
          possible[check] = distances[[8, i]] * 10
        end
      else
        check = location.clone
        check[12] = "B"
        check[i] = nil
        if distances[[i, 12]]
          possible[check] = distances[[i, 12]] * 10
        else
          possible[check] = distances[[12, i]] * 10
        end
      end
    elsif location[i] == "C"
      next if [location[9], location[13]].any? { |val|
        val and val != "C"
      }
      next if anythingBetween(location, i, "C")
      if location[13]
        check = location.clone
        check[9] = "C"
        check[i] = nil
        if distances[[i, 9]]
          possible[check] = distances[[i, 9]] * 100
        else
          possible[check] = distances[[9, i]] * 100
        end
      else
        check = location.clone
        check[13] = "C"
        check[i] = nil
        if distances[[i, 13]]
          possible[check] = distances[[i, 13]] * 100
        else
          possible[check] = distances[[13, i]] * 100
        end
      end
    elsif location[i] == "D"
      next if [location[10], location[14]].any? { |val|
        val and val != "D"
      }
      next if anythingBetween(location, i, "D")
      if location[14]
        check = location.clone
        check[10] = "D"
        check[i] = nil
        if distances[[i, 10]]
          possible[check] = distances[[i, 10]] * 1000
        else
          possible[check] = distances[[10, i]] * 1000
        end
      else
        check = location.clone
        check[14] = "D"
        check[i] = nil
        if distances[[i, 14]]
          possible[check] = distances[[i, 14]] * 1000
        else
          possible[check] = distances[[14, i]] * 1000
        end
      end
    end
  end
  return possible
end

def part1(input)
  rooms = [[], [], [], []]
  locations = []
  count = 0
  for i in 1..11
    next if [3, 5, 7, 9].include? i
    if input[1].slice(i) == "."
      locations[count] = nil
    else
      locations[count] = input[1].slice(i)
    end
    count += 1
  end
  for i in 3...input[2].split("#").length
    val = input[2].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  for i in 1...input[3].split("#").length  
    val = input[3].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  finish = [nil, nil, nil, nil, nil, nil, nil, "A", "B", "C", "D", "A", "B", "C", "D"]
  #locations = [nil, nil, nil, nil, nil, nil, nil, rooms[0][0], rooms[1][0], rooms[2][0], rooms[3][0], rooms[0][1], rooms[1][1], rooms[2][1], rooms[3][1]]
  distances = {
    locations => 0
  }
  queue = {
    0 => [locations],
  }
  previous = {
    locations => nil,
  }
  count = 0
  while queue
    minLen = queue.keys.min
    curr = queue[minLen][0]
    #print curr
    #puts
    why = [nil, "A", "B", "A", nil, nil, nil, nil, nil, "C", "D", nil, "B", "C", "D"]
    #puts distances[why] if distances[why]
    #puts "huh" if curr == why
    if curr == finish
      a = curr
      while previous[a]
        puts distances[previous[a]]
        print previous[a]
        puts
        a = previous[a]
      end
      return distances[curr]
    end
    #print curr
    #puts
    #puts distances[curr]
    toAdd = getAllPossibleNext(curr)
    #puts toAdd
    toAdd.delete_if { |key, value|
      distances[key] and distances[curr] + value >= distances[key]
    }
    for i in toAdd.keys
      dist = toAdd[i] + distances[curr]
      if not queue[dist]
        queue[dist] = []
      end
      queue[dist].append(i)
      distances[i] = dist
      previous[i] = curr
    end
    queue[minLen].delete(curr)
    if queue[minLen].length == 0
      queue.delete(minLen)
    end
    count += 1
    #puts queue
    #break if count == 3
  end
end

def distances(p1, p2)
  lengths = {
    [0, 7] => 3,
    [1, 7] => 2,
    [2, 7] => 2,
    [3, 7] => 4,
    [4, 7] => 6,
    [5, 7] => 8,
    [6, 7] => 9,
    [0, 8] => 5,
    [1, 8] => 4,
    [2, 8] => 2,
    [3, 8] => 2,
    [4, 8] => 4,
    [5, 8] => 6,
    [6, 8] => 7,
    [0, 9] => 7,
    [1, 9] => 6,
    [2, 9] => 4,
    [3, 9] => 2,
    [4, 9] => 2,
    [5, 9] => 4,
    [6, 9] => 5,
    [0, 10] => 9,
    [1, 10] => 8,
    [2, 10] => 6,
    [3, 10] => 4,
    [4, 10] => 2,
    [5, 10] => 2,
    [6, 10] => 3,
    [0, 11] => 4,
    [1, 11] => 3,
    [2, 11] => 3,
    [3, 11] => 5,
    [4, 11] => 7,
    [5, 11] => 9,
    [6, 11] => 10,
    [0, 12] => 6,
    [1, 12] => 5,
    [2, 12] => 3,
    [3, 12] => 3,
    [4, 12] => 5,
    [5, 12] => 7,
    [6, 12] => 8,
    [0, 13] => 8,
    [1, 13] => 7,
    [2, 13] => 5,
    [3, 13] => 3,
    [4, 13] => 3,
    [5, 13] => 5,
    [6, 13] => 6,
    [0, 14] => 10,
    [1, 14] => 9,
    [2, 14] => 7,
    [3, 14] => 5,
    [4, 14] => 3,
    [5, 14] => 3,
    [6, 14] => 4,
  }
  if p1 > p2
    add = 0
    while not lengths[[p2, p1 - 4 * add]]
      add += 1
    end
    return lengths[[p2, p1 - 4 * add]] + add
  else
    add = 0
    while not lengths[[p1, p2 - 4 * add]]
      add += 1
    end
    return lengths[[p1, p2 - 4 * add]] + add
  end
end

def getAllPossibleNext2(location)
  #returns a hash of possible states mapped
  #to the cost to get to that state
  energyCosts = {
    "A" => 1,
    "B" => 10,
    "C" => 100,
    "D" => 1000
  }
  right = {
    7 => "A",
    8 => "B",
    9 => "C",
    10 => "D"
  }
  
  possible = {}
  for i in 7...11
    next if not location[i]
    next if location[i] == location[i + 4] and location[i] == location[i + 8] and location[i] == location[i + 12] and location[i] == right[i]
    for j in 0...7
      next if anythingBetween(location, j, right[i])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        possible[check] = distances(i, j) * energyCosts[check[j]]
      end
    end
  end
  for i in 11...15
    next if not location[i]
    next if location[i] == location[i + 4] and location[i] == location[i + 8] and location[i] == right[i - 4]
    next if location[i - 4]
    for j in 0...7
      next if anythingBetween(location, j, right[i - 4])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        possible[check] = distances(i, j) * energyCosts[check[j]]
      end
    end
  end
  for i in 15...19
    next if not location[i]
    next if location[i] == location[i + 4] and location[i] == right[i - 8]
    next if location[i - 4]
    for j in 0...7
      next if anythingBetween(location, j, right[i - 8])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        possible[check] = distances(i, j) * energyCosts[check[j]]
      end
    end
  end
  for i in 19...23
    next if not location[i]
    next if location[i] == right[i - 12]
    next if location[i - 4]
    for j in 0...7
      next if anythingBetween(location, j, right[i - 12])
      if location[j] == nil
        check = location.clone
        check[j] = check[i]
        check[i] = nil
        possible[check] = distances(i, j) * energyCosts[check[j]]
      end
    end
  end
  for i in 0...7
    next if not location[i]
    if location[i] == "A"
      next if [location[7], location[11], location[15], location[19]].any? { |val|
        val and val != "A"
      }
      next if anythingBetween(location, i, "A")
      if location[11]
        check = location.clone
        check[7] = "A"
        check[i] = nil
        possible[check] = distances(i, 7)
      elsif location[15]
        check = location.clone
        check[11] = "A"
        check[i] = nil
        possible[check] = distances(i, 11)
      elsif location[19]
        check = location.clone
        check[15] = "A"
        check[i] = nil
        possible[check] = distances(i, 15)
      else
        check = location.clone
        check[19] = "A"
        check[i] = nil
        possible[check] = distances(i, 19)
      end
    elsif location[i] == "B"
      next if [location[8], location[12], location[16], location[20]].any? { |val|
        val and val != "B"
      }
      next if anythingBetween(location, i, "B")
      if location[12]
        check = location.clone
        check[8] = "B"
        check[i] = nil
        possible[check] = distances(i, 8) * 10
      elsif location[16]
        check = location.clone
        check[12] = "B"
        check[i] = nil
        possible[check] = distances(i, 12) * 10
      elsif location[20]
        check = location.clone
        check[16] = "B"
        check[i] = nil
        possible[check] = distances(i, 16) * 10
      else
        check = location.clone
        check[20] = "B"
        check[i] = nil
        possible[check] = distances(i, 20) * 10
      end
    elsif location[i] == "C"
      next if [location[9], location[13], location[17], location[21]].any? { |val|
        val and val != "C"
      }
      next if anythingBetween(location, i, "C")
      if location[13]
        check = location.clone
        check[9] = "C"
        check[i] = nil
        possible[check] = distances(i, 9) * 100
      elsif location[17]
        check = location.clone
        check[13] = "C"
        check[i] = nil
        possible[check] = distances(i, 13) * 100
      elsif location[21]
        check = location.clone
        check[17] = "C"
        check[i] = nil
        possible[check] = distances(i, 17) * 100
      else
        check = location.clone
        check[21] = "C"
        check[i] = nil
        possible[check] = distances(i, 21) * 100
      end
    elsif location[i] == "D"
      next if [location[10], location[14], location[18], location[22]].any? { |val|
        val and val != "D"
      }
      next if anythingBetween(location, i, "D")
      if location[14]
        check = location.clone
        check[10] = "D"
        check[i] = nil
        possible[check] = distances(i, 10) * 1000
      elsif location[18]
        check = location.clone
        check[14] = "D"
        check[i] = nil
        possible[check] = distances(i, 14) * 1000
      elsif location[22]
        check = location.clone
        check[18] = "D"
        check[i] = nil
        possible[check] = distances(i, 18) * 1000
      else
        check = location.clone
        check[22] = "D"
        check[i] = nil
        possible[check] = distances(i, 22) * 1000
      end
    end
  end
  return possible
end

def printParse(loc)
  line = "#############"
  puts line
  line = "#"
  for i in 0...7
    if loc[i]
      line += loc[i]
    else
      line += "."
    end
    if [1, 2, 3, 4].include? i
      line += "."
    end
  end
  puts line + "#"
  line = "###"
  for i in 7...11
    if loc[i]
      line += loc[i]
    else
      line += "."
    end
    line += "#"
  end
  puts line + "##"
  line = "  #"
  for i in 11...15
    if loc[i]
      line += loc[i]
    else
      line += "."
    end
    line += "#"
  end
  puts line
  line = "  #"
  for i in 15...19
    if loc[i]
      line += loc[i]
    else
      line += "."
    end
    line += "#"
  end
  puts line
  line = "  #"
  for i in 19...23
    if loc[i]
      line += loc[i]
    else
      line += "."
    end
    line += "#"
  end
  puts line
  puts "  #########"
end

def part2(input)
  rooms = [[], [], [], []]
  locations = []
  count = 0
  for i in 1..11
    next if [3, 5, 7, 9].include? i
    if input[1].slice(i) == "."
      locations[count] = nil
    else
      locations[count] = input[1].slice(i)
    end
    count += 1
  end
  for i in 3...input[2].split("#").length
    val = input[2].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  for i in 1...input[3].split("#").length  
    val = input[3].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  for i in 1...input[4].split("#").length  
    val = input[4].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  for i in 1...input[5].split("#").length  
    val = input[5].split("#")[i]
    if val == "."
      locations[count] = nil
    else
      locations[count] = val
    end
    count += 1
  end
  finish = [nil, nil, nil, nil, nil, nil, nil, "A", "B", "C", "D", "A", "B", "C", "D", "A", "B", "C", "D", "A", "B", "C", "D"]
  #locations = [nil, nil, nil, nil, nil, nil, nil, rooms[0][0], rooms[1][0], rooms[2][0], rooms[3][0], rooms[0][1], rooms[1][1], rooms[2][1], rooms[3][1]]
  distances = {
    locations => 0
  }
  queue = {
    0 => [locations],
  }
  previous = {
    locations => nil,
  }
  count = 0
  while queue.size != 0
    minLen = queue.keys.min
    #puts queue
    curr = queue[minLen][0]
    if curr == finish
      a = curr
      while previous[a]
        puts distances[previous[a]]
        printParse(previous[a])
        puts
        a = previous[a]
      end
      puts count
      return distances[curr]
    end
    #print curr
    #puts
    #puts distances[curr]
    toAdd = getAllPossibleNext2(curr)
    #puts toAdd
    toAdd.delete_if { |key, value|
      distances[key] and distances[curr] + value >= distances[key]
    }
    for i in toAdd.keys
      dist = toAdd[i] + distances[curr]
      if not queue[dist]
        queue[dist] = []
      end
      queue[dist].append(i)
      distances[i] = dist
      previous[i] = curr
    end
    queue[minLen].delete(curr)
    if queue[minLen].length == 0
      queue.delete(minLen)
    end
    count += 1
    #puts queue
    #break if count == 3
  end
  return "no path found"
end

#puts part1(sinput.clone)
#puts
#puts
#puts part1(input.clone)

#puts

#puts part2(sinput.clone)
puts part2(input.clone)

#not right
#puts 10 + 10 + 10 + 100 + 100 + 100 + 13000 + 7 + 500 + 400 + 6 + 130 + 6
#still too high (14377)
#puts 30 + 300 + 13000 + 7 + 900 + 3 + 60 + 7 + 70
#14363 still wrong
#puts 60 + 300 + 5000 + 200 + 3 + 300 + 3 + 30 + 11 + 8000 + 400 + 50 +6
#puts 60 + 500 + 5000 + 6 + 700 + 7 + 30 + 8000 + 50 + 9 + 9

#part 2
#40165 is too low

#puts 11000 + 11000 + 11000 + 4000 + 700 + 700 + 700 + 700 + 100 + 70 + 70 + 60 + 10 + 10 + 10 + 9
#40185 is too low

#unoptimizable
d = 1000 + 2000 + 3000 + 1000 + 10000 + 2000 + 3 * 6000
c = 100 + 200 + 300 + 400 + 1000 + 2 * 200 + 2 * 200
b = 40 + 30 + 20 + 10 + 100 + 40 + 20 + 20
a = 4 + 4 + 3 + 2 + 10 + 6 + 2 * 4 + 2

#puts a + b + c + d


#puts 40139 + 20 + 20 + 6