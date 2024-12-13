def playerWinsBattle(player, boss)
  while player[0] > 0 and boss[0] > 0
    #player turn
    damage = player[1] - boss[2]
    if damage < 1
      damage = 1
    end
    boss[0] -= damage
    if boss[0] <= 0
      return true
    end
    #boss turn
    damage = boss[1] - player[2]
    if damage < 1
      damage = 1
    end
    player[0] -= damage
    if player[0] <= 0
      return false
    end
  end
end

def addArrs(w, a, r1=nil, r2=nil)
  result = [0, 0, 0]
  for i in 0...3
    result[i] += w[i]
    result[i] += a[i]
    result[i] += r1[i] if r1
    result[i] += r2[i] if r2
  end
  return result
end

def getAllCombos(w, a, r)
  combos = []
  weapons = w.keys
  rings = r.keys.combination(2).to_a + r.keys.combination(1).to_a
  for i in weapons
    combos << w[i].clone
    for j in a.keys
      combos << addArrs(w[i], a[j])
      for k in rings
        if k.length == 1
          combos << addArrs(w[i], a[j], r[k[0]])
        else
          combos << addArrs(w[i], a[j], r[k[0]], r[k[1]])
        end
      end
    end
    for k in rings
      if k.length == 1
        combos << addArrs(w[i], r[k[0]])
      else
        combos << addArrs(w[i], r[k[0]], r[k[1]])
      end
    end
  end
  return combos.sort { |i, j| i[0] <=> j[0] }
end

def part1()
  weapons = { "d" => [8, 4, 0],
    "s" => [10, 5, 0],
    "w" => [25, 6, 0],
    "l" => [40, 7, 0],
    "g" => [74, 8, 0]
  }
  armor = { "l" => [13, 0, 1],
    "c" => [31, 0, 2],
    "s" => [53, 0, 3],
    "b" => [75, 0, 4],
    "p" => [102, 0, 5]
  }
  rings = { "da1" => [25, 1, 0],
    "da2" => [50, 2, 0],
    "da3" => [100, 3, 0],
    "de1" => [20, 0, 1],
    "de2" => [40, 0, 2],
    "de3" => [80, 0, 3]
  }
  playerStats = [100, 0, 0]
  bossStats = [109, 8, 2]
  #playerStats = [8, 5, 5]
  #bossStats = [12, 7, 2]
  combos = getAllCombos(weapons, armor, rings)
  for i in combos
    playerStats[1] += i[1]
    playerStats[2] += i[2]
    if playerWinsBattle(playerStats.clone, bossStats.clone)
      return i[0]
    end
    playerStats[1] -= i[1]
    playerStats[2] -= i[2]
  end
  return 0
end

def part2()
  weapons = { "d" => [8, 4, 0],
    "s" => [10, 5, 0],
    "w" => [25, 6, 0],
    "l" => [40, 7, 0],
    "g" => [74, 8, 0]
  }
  armor = { "l" => [13, 0, 1],
    "c" => [31, 0, 2],
    "s" => [53, 0, 3],
    "b" => [75, 0, 4],
    "p" => [102, 0, 5]
  }
  rings = { "da1" => [25, 1, 0],
    "da2" => [50, 2, 0],
    "da3" => [100, 3, 0],
    "de1" => [20, 0, 1],
    "de2" => [40, 0, 2],
    "de3" => [80, 0, 3]
  }
  playerStats = [100, 0, 0]
  bossStats = [109, 8, 2]
  #playerStats = [8, 5, 5]
  #bossStats = [12, 7, 2]
  combos = getAllCombos(weapons, armor, rings)
  for i in combos.reverse
    #puts i[0]
    playerStats[1] += i[1]
    playerStats[2] += i[2]
    if not playerWinsBattle(playerStats.clone, bossStats.clone)
      return i[0]
    end
    playerStats[1] -= i[1]
    playerStats[2] -= i[2]
  end
  return 0
end

puts part1()

puts part2()
