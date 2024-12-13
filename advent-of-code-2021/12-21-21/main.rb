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

def getNewNum(die, maxDie)
  die += 1
  if die > maxDie
    die = 1
  end
  return die
end

def part1(p1Pos, p2Pos)
  p1Score = 0
  p2Score = 0
  rolls = 0
  dieNum = 1
  dieSize = 100
  p1Turn = true
  while p1Score < 1000 and p2Score < 1000
    if p1Turn
      3.times { 
        p1Pos += dieNum
        dieNum = getNewNum(dieNum, dieSize)
      }
      p1Pos %= 10
      if p1Pos == 0
        p1Pos = 10
      end
      p1Score += p1Pos
      #puts p1Score
      p1Turn = false
    else
      3.times {
        p2Pos += dieNum
        dieNum = getNewNum(dieNum, dieSize)
      }
      p2Pos %= 10
      if p2Pos == 0
        p2Pos = 10
      end
      p2Score += p2Pos
      #puts p2Score
      p1Turn = true
    end
    rolls += 3
    #puts rolls
  end
  if p1Score >= 1000
    #puts rolls
    #puts p2Score
    return rolls * p2Score
  else
    #puts rolls
    return rolls * p1Score
  end
end

class Game

  @@solved = {}
  @@playingTo = 21
  @@frequencies = {
    3 => 1,
    4 => 3,
    5 => 6,
    6 => 7,
    7 => 6,
    8 => 3,
    9 => 1
  }

  def self.playGame(p1Pos, p2Pos, p1Score, p2Score, p1Turn)
    if p1Pos > 10
      p1Pos -= 10
      p1Score -= 10
    end
    if p2Pos > 10
      p2Pos -= 10
      p2Score -= 10
    end
    if @@solved[[p1Pos, p2Pos, p1Score, p2Score, p1Turn]]
      return @@solved[[p1Pos, p2Pos, p1Score, p2Score, p1Turn]]
    end
    p1Wins = 0
    p2Wins = 0
    if p1Score >= @@playingTo
      return [1, 0]
    end
    if p2Score >= @@playingTo
      return [0, 1]
    end
    subUniverses = {}
    if p1Turn
      for i in 3..9
        subUniverses[i] = Game.playGame(p1Pos + i, p2Pos, p1Score + p1Pos + i, p2Score, false)
      end
    else
      for i in 3..9
        subUniverses[i] = Game.playGame(p1Pos, p2Pos + i, p1Score, p2Score + p2Pos + i, true)
      end
    end
    for i in subUniverses.keys
      p1Wins += subUniverses[i][0] * @@frequencies[i]
      p2Wins += subUniverses[i][1] * @@frequencies[i]
    end
    @@solved[[p1Pos, p2Pos, p1Score, p2Score, p1Turn]] = [p1Wins, p2Wins]
    return [p1Wins, p2Wins]
  end
  
end

def specialAdd(pos, roll)
  pos += roll
  if pos > 10
    pos -= 10
  end
  return pos
end

def part2(p1Pos, p2Pos)
  a = Game.playGame(p1Pos, p2Pos, 0, 0, true)
  return a.max
end

t = Time.now
#puts part1(4, 8)
puts part1(3, 4)

puts

#puts part2(4, 8)
puts part2(3, 4)
puts Time.now - t