require 'set'

fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.rstrip
  end
end

def part1(input)
  rTurn = { "R" => "D", "D" => "L", "L" => "U", "U" => "R" }
  lTurn = { "R" => "U", "D" => "R", "L" => "D", "U" => "L" }
  map = {}
  last = 0
  for i in 0...input.length
    last = i
    break if input[i] == ""
    for j in 0...input[i].length
      if input[i].slice(j) == "."
        map[[i, j]] = "open"
      elsif input[i].slice(j) == "#"
        map[[i, j]] = "wall"
      end
    end
  end
  puts "mapped"
  steps = input[last + 1]
  instructions = []
  num = ""
  for i in steps.split("")
    if ["L", "R"].include? i
      instructions << [num.to_i, i]
      num = ""
    else
      num += i
    end
  end
  instructions << [num.to_i, "C"]
  puts "instructions"
  #puts steps  #
  # puts map
  facing = "R"
  start = map.keys.keep_if { |i| i[0] == 0 }.min { |i, j| i[1] <=> j[1] }
  # print start
  # puts
  # print instructions
  # puts
  for i in instructions
    # print i
    # puts facing
    moved = 0
    while moved < i[0]
      if facing == "R"
        nextLoc = [start[0], start[1] + 1]
      elsif facing == "L"
        nextLoc = [start[0], start[1] - 1]
      elsif facing == "U"
        nextLoc = [start[0] - 1, start[1]]
      elsif facing == "D"
        nextLoc = [start[0] + 1, start[1]]
      end
      if map[nextLoc] == "open"
        start = nextLoc.clone
        # puts "normal"
        # print start
        # puts
        # puts
        moved += 1
      elsif map[nextLoc] == "wall"
        # puts "wall"
        # print nextLoc
        # puts
        # puts
        moved = i[0]
      else
        wrap = []
        if facing == "R"
          wrap = map.keys.keep_if { |j| j[0] == start[0] }.min { |j, k| j[1] <=> k[1] }
        elsif facing == "L"
          wrap = map.keys.keep_if { |j| j[0] == start[0] }.max { |j, k| j[1] <=> k[1] }
        elsif facing == "U"
          wrap = map.keys.keep_if { |j| j[1] == start[1] }.max { |j, k| j[0] <=> k[0] }
        elsif facing == "D"
          wrap = map.keys.keep_if { |j| j[1] == start[1] }.min { |j, k| j[0] <=> k[0] }
        end
        if map[wrap] == "open"
          start = wrap.clone
          # puts "wrap"
          # print start
          # puts
          # puts
          moved += 1
        else
          # puts "wallwrap"
          # print nextLoc
          # puts
          # puts
          moved = i[0]
        end
      end
    end
    if i[1] == "R"
      facing = rTurn[facing]
    elsif i[1] == "L"
      facing = lTurn[facing]
    end
  end
  vals = ["R", "D", "L", "U"]
  print start
  puts
  puts facing
  return 1000 * (start[0] + 1) + 4 * (start[1] + 1) + vals.index(facing)
end


#194025 too high
#22512 too low

def part2(input)
  s = 50
  #s = 4
  rTurn = { "R" => "D", "D" => "L", "L" => "U", "U" => "R" }
  lTurn = { "R" => "U", "D" => "R", "L" => "D", "U" => "L" }
  map = {}
  faces = [[], [], [], [], [], []]
  
  last = 0
  for i in 0...input.length
    last = i
    break if input[i] == ""
    for j in 0...input[i].length
      if input[i].slice(j) == "."
        map[[i, j]] = "open"
      elsif input[i].slice(j) == "#"
        map[[i, j]] = "wall"
      end
      if i / s == 0 and j / s == 1
        faces[1] << [i, j]
      elsif i / s == 0 and j / s == 2
        faces[0] << [i, j]
      elsif i / s == 1 and j / s == 1
        faces[2] << [i, j]
      elsif i / s == 2 and j / s == 1
        faces[4] << [i, j]
      elsif i / s == 2 and j / s == 0
        faces[5] << [i, j]
      elsif i / s == 3 and j / s == 0
        faces[3] << [i, j]
      end
    end
  end
  puts "mapped"
  connections = {}
  for i in faces[0]
    if i[0] == 0
      connect = []
      connect[0] = 4 * s - 1
      connect[1] = i[1] - (2 * s)
      connections[[i, "U"]] = [connect, "U"]
    end
    if i[1] == (3 * s) - 1
      connect = []
      connect[1] = (2 * s) - 1
      connect[0] = (3 * s) - 1 - i[0]
      connections[[i, "R"]] = [connect, "L"]
    end
    if i[0] == s - 1
      connect = []
      connect[1] = (2 * s) - 1
      connect[0] = i[1] - s
      connections[[i, "D"]] = [connect, "L"]
    end
  end
  for i in faces[1]
    if i[0] == 0
      connect = []
      connect[1] = 0
      connect[0] = 2 * s + i[1]
      connections[[i, "U"]] = [connect, "R"]
    end
    if i[1] == s
      connect = []
      connect[0] = (3 * s) - 1 - i[0]
      connect[1] = 0
      connections[[i, "L"]] = [connect, "R"]
    end
  end
  for i in faces[2]
    if i[1] == s
      connect = []
      connect[1] = i[0] - s
      connect[0] = 2 * s
      connections[[i, "L"]] = [connect, "D"]
    end
    if i[1] == (2 * s) - 1
      connect = []
      connect[0] = s - 1
      connect[1] = s + i[0]
      connections[[i, "R"]] = [connect, "U"]
    end
  end
  for i in faces[3]
    if i[0] == (4 * s) - 1
      connect = []
      connect[0] = 0
      connect[1] = i[1] + 2 * s
      connections[[i, "D"]] = [connect, "D"]
    end
    if i[1] == 0
      connect = []
      connect[0] = 0
      connect[1] = i[0] - 2 * s
      connections[[i, "L"]] = [connect, "D"]
    end
    if i[1] == s - 1
      connect = []
      connect[0] = (3 * s) - 1
      connect[1] = i[0] - (2 * s)
      connections[[i, "R"]] = [connect, "U"]
    end
  end
  for i in faces[4]
    if i[1] == (2 * s) - 1
      connect = []
      connect[1] = (3 * s) - 1
      connect[0] = (3 * s) - 1 - i[0]
      connections[[i, "R"]] = [connect, "L"]
    end
    if i[0] == (3 * s) - 1
      connect = []
      connect[1] = s - 1
      connect[0] = i[1] + 2 * s
      connections[[i, "D"]] = [connect, "L"]
    end
  end
  for i in faces[5]
    if i[1] == 0
      connect = []
      connect[1] = s
      connect[0] = (3 * s) - 1 - i[0]
      connections[[i, "L"]] = [connect, "R"]
    end
    if i[0] == 2 * s
      connect = []
      connect[1] = s
      connect[0] = s + i[1]
      connections[[i, "U"]] = [connect, "R"]
    end
  end
  #should be all good above
  puts "zipped"
      
  steps = input[last + 1]
  instructions = []
  num = ""
  for i in steps.split("")
    if ["L", "R"].include? i
      instructions << [num.to_i, i]
      num = ""
    else
      num += i
    end
  end
  instructions << [num.to_i, "C"]
  puts "instructions"
  #puts steps  #
  # puts map
  facing = "R"
  start = map.keys.keep_if { |i| i[0] == 0 }.min { |i, j| i[1] <=> j[1] }
  # print start
  # puts
  # print instructions
  # puts
  for i in instructions
    # print start
#     puts
#     print i
#     puts
#     puts facing
    moved = 0
    while moved < i[0]
      if facing == "R"
        nextLoc = [start[0], start[1] + 1]
      elsif facing == "L"
        nextLoc = [start[0], start[1] - 1]
      elsif facing == "U"
        nextLoc = [start[0] - 1, start[1]]
      elsif facing == "D"
        nextLoc = [start[0] + 1, start[1]]
      end
      if map[nextLoc] == "open"
        start = nextLoc.clone
        # puts "normal"
        # print start
        # puts
        # puts
        moved += 1
      elsif map[nextLoc] == "wall"
        # puts "wall"
        # print nextLoc
        # puts
        # puts
        moved = i[0]
      else
        nextLoc = connections[[start, facing]].clone
        # puts "start: "
        # print start
        # puts facing
        # puts "next"
        # print nextLoc
        # puts
        # puts "next type"
        # puts map[nextLoc[0]]
        if not nextLoc
          puts map[start].to_s
          print start
          puts
          puts facing
          raise 'bad'
        end
        wrap = nextLoc[0]
        newFace = nextLoc[1]
        if map[wrap] == "open"
          # puts "open"
          start = wrap.clone
          facing = newFace
          # puts "wrap"
          # print start
          # puts
          # puts
          moved += 1
        else
          # puts "wall"
          # puts "wallwrap"
          # print start
          # puts
          # puts facing
          # print nextLoc
          # puts
#           print nextLoc
#           puts
#           puts
          moved = i[0]
        end
        # puts
        # puts
        # puts
      end
      # print start
      # puts
      # puts facing
    end
    if i[1] == "R"
      facing = rTurn[facing]
    elsif i[1] == "L"
      facing = lTurn[facing]
    end
  end
  vals = ["R", "D", "L", "U"]
  print start
  puts
  puts facing
  return 1000 * (start[0] + 1) + 4 * (start[1] + 1) + vals.index(facing)
end

#puts part1(data)
puts part2(data)