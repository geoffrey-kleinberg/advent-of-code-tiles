require 'set'

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

def allIncl(list1, list2)
  return list1.to_set.subset? list2.to_set
end

def isWinning(board, list)
  mainDiag = []
  transDiag = []
  for row in 0...5
    return true if allIncl(board[row], list)
    return true if allIncl(board.clone.map { |i| i[row] }, list)
    mainDiag << board[row][row]
    transDiag << board[row][5 - row]
  end
  return true if allIncl(mainDiag, list)
  return true if allIncl(transDiag, list)
      
end

def calcScore(board, list, lastNum)
  return lastNum.to_i * board.flatten.inject(0) { |sum, i| (list.include? i) ? sum : sum + i.to_i}
end

def part1(input)
  nums = input[0].split(",")
  boards = []
  for i in 0...(input.length - 1) / 6
    boards << input.slice((i * 6) + 2, 5).map { |j| j.split(" ") }
  end
  for i in 1..nums.length
    for board in boards
      if isWinning(board.clone, nums.first(i))
        return calcScore(board, nums.first(i), nums[i - 1])
      end
    end
  end
  return 0
end

def part2(input)
  nums = input[0].split(",")
  boards = []
  for i in 0...(input.length - 1) / 6
    boards << input.slice((i * 6) + 2, 5).map { |j| j.split(" ") }
  end
  for i in 1..nums.length
    for board in boards
      if isWinning(board.clone, nums.first(i))
        last = board
        lastNum = nums[i - 1]
        lastI = i
        boards.delete(board)
        break if boards.length == 0
      end
    end
    break if boards.length == 0
  end
  return calcScore(last, nums.first(lastI), lastNum)
end


#puts part1(sinput)
puts part1(input.clone)

puts

#puts part2(sinput)
puts part2(input.clone)