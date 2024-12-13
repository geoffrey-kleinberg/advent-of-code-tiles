require 'set'

def getMoveCost(moves)
  costs = {
    "m" => 53,
    "d" => 73,
    "s" => 113,
    "p" => 173,
    "r" => 229
  }
  return moves.inject(0) { |sum, i| sum + costs[i[0]] }
end

def getMinCost(pHP, pMana, pArmor, bHP, bDam, pTurn, moves, mem={})
  # if mem[[pHP, pMana, bHP, pTurn, moves]]
#    puts "memo"
#    return mem[[pHP, pMana, bHP, pTurn, moves]]
#   end
  # puts "BHP"
  # puts bHP
  #puts moves.length
  armor = 0
  manaBoost = 0
  damageBoost = 0
  moves = moves.map { |i| i.clone }
  aActive = false
  dActive = false
  mActive = false
  for i in moves
    if i[1] and i[1] > 0
      if i[0] == "s"
        armor += 7
        aActive = true if i[1] > 1
      elsif i[0] == "p"
        damageBoost += 3
        dActive = true if i[1] > 1
      elsif i[0] == "r"
        manaBoost += 101
        mActive = true if i[1] > 1
      else
        raise 'something'
      end
      i[1] -= 1
    end
  end
  if bHP - damageBoost <= 0
    # puts "returning"
    # puts bHP
    # puts damageBoost
    # puts getMoveCost(moves)
    a = getMoveCost(moves)
    #mem[[pHP, pMana, bHP, pTurn, moves]] = a
    return a
  end
  if pHP <= 0
    puts "what"
    #mem[[pHP, pMana, bHP, pTurn, moves]] = nil
    return nil
  end
  if pTurn
    spells = ["m", "d", "s", "p", "r"]
    possible = []
    pMana += manaBoost
    bHP -= damageBoost
    for i in spells
      moveCopy = moves.clone
      if i == "m" and pMana >= 53
        moveCopy.append(["m"])
        # puts "HERE: "
        # puts pHP
        # puts pMana - 53
        # puts 0
        # puts bHP - 4
        # puts bDam
        # print moveCopy
        # puts
        # puts
        puts "a" if moves.length == 0
        val = getMinCost(pHP, pMana - 53, 0, bHP - 4, bDam, false, moveCopy, mem)
        puts "b" if moves.length == 0
        puts val if moves.length == 0
        # puts val
        # puts
      elsif i == "d" and pMana >= 73
        moveCopy.append(["d"])
        val = getMinCost(pHP + 2, pMana - 73, 0, bHP - 2, bDam, false, moveCopy, mem)
      elsif i == "s" and pMana >= 113 and not aActive
        moveCopy.append(["s", 6])
        val = getMinCost(pHP, pMana - 113, 0, bHP, bDam, false, moveCopy, mem)
      elsif i == "p" and pMana >= 173 and not dActive
        moveCopy.append(["p", 6])
        val = getMinCost(pHP, pMana - 173, 0, bHP, bDam, false, moveCopy, mem)
      elsif i == "r" and pMana >= 229 and not mActive
        moveCopy.append(["r", 5])
        val = getMinCost(pHP, pMana - 229, 0, bHP, bDam, false, moveCopy, mem)
      end
      possible.append(val) if val
    end
    # print possible
#     puts
    thisBest = possible.min
    #mem[[pHP, pMana, bHP, pTurn, moves]] = thisBest
    return thisBest
  else
    damage = [1, bDam - armor].max
    if pHP - damage <= 0
      #mem[[pHP, pMana, bHP, pTurn, moves]] = nil
      return nil
    end
    thisBest = getMinCost(pHP - damage, pMana + manaBoost, 0, bHP - damageBoost, bDam, true, moves, mem)
    
    #mem[[pHP, pMana, bHP, pTurn, moves]] = thisBest
    # puts "other turn"
    # print moves
    # puts
    # puts damage
    # puts manaBoost
    # puts damageBoost
    return thisBest
  end
  puts 'AHH'
end

def recursiveMinCostP2(pHP, pMana, pArmor, bHP, bDam, pTurn, moves, mem={})
  # if mem[[pHP, pMana, bHP, pTurn, moves]]
#    puts "memo"
#    return mem[[pHP, pMana, bHP, pTurn, moves]]
#   end
  # puts "BHP"
  # puts bHP
  #puts moves.length
  armor = 0
  manaBoost = 0
  damageBoost = 0
  moves = moves.map { |i| i.clone }
  aActive = false
  dActive = false
  mActive = false
  for i in moves
    if i[1] and i[1] > 0
      if i[0] == "s"
        armor += 7
        aActive = true if i[1] > 1
      elsif i[0] == "p"
        damageBoost += 3
        dActive = true if i[1] > 1
      elsif i[0] == "r"
        manaBoost += 101
        mActive = true if i[1] > 1
      else
        raise 'something'
      end
      i[1] -= 1
    end
  end
  if bHP - damageBoost <= 0
    # puts "returning"
    # puts bHP
    # puts damageBoost
    # puts getMoveCost(moves)
    a = getMoveCost(moves)
    #mem[[pHP, pMana, bHP, pTurn, moves]] = a
    return a
  end
  if pHP <= 0
    puts "what"
    #mem[[pHP, pMana, bHP, pTurn, moves]] = nil
    return nil
  end
  if pTurn
    pHP -= 1
    if pHP <= 0
      puts "this"
      return nil
    end
    spells = ["m", "d", "s", "p", "r"]
    possible = []
    pMana += manaBoost
    bHP -= damageBoost
    for i in spells
      moveCopy = moves.clone
      if i == "m" and pMana >= 53
        moveCopy.append(["m"])
        # puts "HERE: "
        # puts pHP
        # puts pMana - 53
        # puts 0
        # puts bHP - 4
        # puts bDam
        # print moveCopy
        # puts
        # puts
        puts "a" if moves.length == 0
        val = getMinCost(pHP, pMana - 53, 0, bHP - 4, bDam, false, moveCopy, mem)
        puts "b" if moves.length == 0
        puts val if moves.length == 0
        # puts val
        # puts
      elsif i == "d" and pMana >= 73
        moveCopy.append(["d"])
        val = getMinCost(pHP + 2, pMana - 73, 0, bHP - 2, bDam, false, moveCopy, mem)
        puts "c" if moves.length == 0
        puts val if moves.length == 0
      elsif i == "s" and pMana >= 113 and not aActive
        moveCopy.append(["s", 6])
        val = getMinCost(pHP, pMana - 113, 0, bHP, bDam, false, moveCopy, mem)
        puts "d" if moves.length == 0
        puts val if moves.length == 0
      elsif i == "p" and pMana >= 173 and not dActive
        moveCopy.append(["p", 6])
        val = getMinCost(pHP, pMana - 173, 0, bHP, bDam, false, moveCopy, mem)
        puts "e" if moves.length == 0
        puts val if moves.length == 0
      elsif i == "r" and pMana >= 229 and not mActive
        moveCopy.append(["r", 5])
        val = getMinCost(pHP, pMana - 229, 0, bHP, bDam, false, moveCopy, mem)
        puts "f" if moves.length == 0
        puts val if moves.length == 0
      end
      possible.append(val) if val
    end
    # print possible
#     puts
    thisBest = possible.min
    #mem[[pHP, pMana, bHP, pTurn, moves]] = thisBest
    return thisBest
  else
    damage = [1, bDam - armor].max
    if pHP - damage <= 0
      #mem[[pHP, pMana, bHP, pTurn, moves]] = nil
      return nil
    end
    thisBest = getMinCost(pHP - damage, pMana + manaBoost, 0, bHP - damageBoost, bDam, true, moves, mem)
    
    #mem[[pHP, pMana, bHP, pTurn, moves]] = thisBest
    # puts "other turn"
    # print moves
    # puts
    # puts damage
    # puts manaBoost
    # puts damageBoost
    return thisBest
  end
end

def getWinner(startPHP, startBHP, bDam, playerMoves, part2=false)
  sTimer = 0
  pTimer = 0
  armor = 0
  soFar = []
  for i in playerMoves
    armor = 0
    #puts "BEGINNING OF PLAYER TURN: Player HP: #{startPHP}, Boss HP: #{startBHP}"
    ##part 2
    if part2
      startPHP -= 1
      if startPHP <= 0
        return ["boss"]
      end
    #  puts "Player loses one HP: Player HP: #{startPHP}, Boss HP: #{startBHP}"
    end
    #puts "MANA: #{calcMana(500, soFar)[0]}"
    soFar.append(i)
    ##end part 2
    #player turn
    if sTimer > 0
      armor = 7
      sTimer -= 1
    #  puts "Shield Active: Timer: #{sTimer}"
    end
    if pTimer > 0
      startBHP -= 3
      pTimer -= 1
    #  puts "Poison Active: Boss HP: #{startBHP}, Timer: #{pTimer}"
    end
    if startBHP <= 0
    #  puts "Poison killed boss"
      return ["player"]
    end
    if i == "m"
      startBHP -= 4
    elsif i == "d"
      startBHP -= 2
      startPHP += 2
    elsif i == "s"
      sTimer = 6
    elsif i == "p"
      pTimer = 6
    elsif i == "r"
    else
      raise 'spell unknown'
    end
    #puts "Spell cast: #{i}, player HP: #{startPHP}, Boss HP: #{startBHP}"
    if startBHP <= 0
    #  puts "Spell kills boss"
      return ["player"]
    end
    #boss turn
    armor = 0
    #puts "BEGINNING OF BOSS TURN"
    if sTimer > 0
      armor = 7
      sTimer -= 1
    #  puts "Shield Active: Timer: #{sTimer}"
    end
    if pTimer > 0
      startBHP -= 3
      pTimer -= 1
    #  puts "Poison Active: Boss HP: #{startBHP}, Timer: #{pTimer}"
    end
    if startBHP <= 0
    #  puts "Poison kills boss"
      return ["player"]
    end
    damage = [1, bDam - armor].max
    startPHP -= damage
    #puts "Boss does #{damage} damage, player HP: #{startPHP}"
    if startPHP <= 0
      #puts "boss kills player"
      return ["boss"]
    end
    #puts
    #puts
  end
  if pTimer > 0
    pTimer -= 1
  end
  if sTimer > 0
    sTimer -= 1
  end
  effects = []
  if sTimer > 0
    effects << "s"
  end
  if pTimer > 0
    effects << "p"
  end
  return ["unknown", effects]
end

def calcMana(startMana, playerMoves)
  rTimer = 0
  for i in playerMoves
    if rTimer > 0
      startMana += 101
      rTimer -= 1
    end
    if i == "m"
      startMana -= 53
    elsif i == "d"
      startMana -= 73
    elsif i == "s"
      startMana -= 113
    elsif i == "p"
      startMana -= 173
    elsif i == "r"
      startMana -= 229
      rTimer = 5
    end
    if startMana < 0
      raise 'invalid'
    end
    if rTimer > 0
      startMana += 101
      rTimer -= 1
    end
  end
  if rTimer > 0
    startMana += 101
    rTimer -= 1
  end
  return [startMana, (rTimer == 0) ? false : true]
end

def part1(pHP, pMana, bHP, bDam)
  queue = {
    0 => [[]]
  }
  while true
    minCost = queue.keys.min
    #puts minCost
    curr = queue[minCost][0]
    winner = getWinner(pHP, bHP, bDam, curr)
    if winner[0] == "player"
      return minCost
    elsif winner[0] == "boss"
    elsif winner[0] == "unknown"
      effects = winner[1]
      mana = calcMana(pMana, curr)
      rActive = mana[1]
      mana = mana[0]
      if mana >= 53
        copy = curr.clone
        newCost = minCost + 53
        copy.append("m")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 73
        copy = curr.clone
        newCost = minCost + 73
        copy.append("d")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 113 and not effects.include? "s"
        copy = curr.clone
        newCost = minCost + 113
        copy.append("s")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 173 and not effects.include? "p"
        copy = curr.clone
        newCost = minCost + 173
        copy.append("p")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 229 and not rActive
        copy = curr.clone
        newCost = minCost + 229
        copy.append("r")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
    else
      raise 'winner condition wrong'
    end
    queue[minCost].delete_at(0)
    if queue[minCost].length == 0
      queue.delete(minCost)
    end
  end
  #return getMinCost(pHP, pMana, 0, bHP, bDam, true, [], {})
end


#900 is too low, 1242 is too high
def part2(pHP, pMana, bHP, bDam)
  #return recursiveMinCostP2(pHP, pMana, 0, bHP, bDam, true, [], {})
  queue = {
    0 => [[]]
  }
  while true
    effects = []
    rActive = false
    minCost = queue.keys.min
    curr = queue[minCost][0]
    winner = getWinner(pHP, bHP, bDam, curr, true)
    if winner[0] == "player"
      return minCost
    elsif winner[0] == "boss"
    elsif winner[0] == "unknown"
      effects = winner[1]
      mana = calcMana(pMana, curr)
      rActive = mana[1]
      mana = mana[0]
      if mana >= 53
        copy = curr.clone
        newCost = minCost + 53
        copy.append("m")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 73
        copy = curr.clone
        newCost = minCost + 73
        copy.append("d")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 113 and not effects.include? "s"
        copy = curr.clone
        newCost = minCost + 113
        copy.append("s")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 173 and not effects.include? "p"
        copy = curr.clone
        newCost = minCost + 173
        copy.append("p")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
      if mana >= 229 and not rActive
        copy = curr.clone
        newCost = minCost + 229
        copy.append("r")
        if not queue[newCost]
          queue[newCost] = []
        end
        queue[newCost].append(copy)
      end
    else
      raise 'winner condition wrong'
    end
    queue[minCost].delete_at(0)
    if queue[minCost].length == 0
      queue.delete(minCost)
    end
  end
end

puts part1(50, 500, 51, 9)
puts part2(50, 500, 51, 9)