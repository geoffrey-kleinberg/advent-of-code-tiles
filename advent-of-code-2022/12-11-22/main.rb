fileName = "samplein.txt"
fileName = "input.txt"
data = []
File.open(fileName) do |f|
  f.each do |i|
    data << i.strip
  end
end

def part1(input)
  inspections = [0, 0, 0, 0, 0, 0, 0, 0]
  items = [[79, 98], [54, 65, 75, 74], [79, 60, 97], [74]]
  monkeys = 4
  items = [[77, 69, 76, 77, 50, 58], [75, 70, 82, 83, 96, 64, 62], [53], [85, 64, 93, 64, 99], [61, 92, 71], [79, 73, 50, 90], [50, 89], [83, 56, 64, 58, 93, 91, 56, 65]]
  monkeys = 8
  for round in 1..20
    for i in 0...monkeys
      if i == 0
        #items[i] = items[i].map { |j| j * 19 }
        items[i] = items[i].map { |j| j * 11 }
      elsif i == 1
        #items[i] = items[i].map { |j| j + 6 }
        items[i] = items[i].map { |j| j + 8 }
      elsif i == 2
        #items[i] = items[i].map { |j| j * j }
        items[i] = items[i].map { |j| j * 3 }
      elsif i == 3
        #items[i] = items[i].map { |j| j + 3 }
        items[i] = items[i].map { |j| j + 4 }
      elsif i == 4
        items[i] = items[i].map { |j| j * j }
      elsif i == 5
        items[i] = items[i].map { |j| j + 2 }
      elsif i == 6
        items[i] = items[i].map { |j| j + 3 }
      elsif i == 7
        items[i] = items[i].map { |j| j + 5 }
      end
      inspections[i] += items[i].length
      items[i] = items[i].map { |j| j / 3 }
      while items[i].length != 0
        el = items[i][0]
        if i == 0
          #if el % 23 == 0
          if el % 5 == 0
            #items[2].append(items[i].delete_at(0))
            items[1].append(items[i].delete_at(0))
          else
            #items[3].append(items[i].delete_at(0))
            items[5].append(items[i].delete_at(0))
          end
        elsif i == 1
          #if el % 19 == 0
          if el % 17 == 0
            #items[2].append(items[i].delete_at(0))
            items[5].append(items[i].delete_at(0))
          else
            #items[0].append(items[i].delete_at(0))
            items[6].append(items[i].delete_at(0))
          end
        elsif i == 2
          #if el % 13 == 0
          if el % 2 == 0
            #items[1].append(items[i].delete_at(0))
            items[0].append(items[i].delete_at(0))
          else
            #items[3].append(items[i].delete_at(0))
            items[7].append(items[i].delete_at(0))
          end
        elsif i == 3
          #if el % 17 == 0
          if el % 7 == 0
            #items[0].append(items[i].delete_at(0))
            items[7].append(items[i].delete_at(0))
          else
            #items[1].append(items[i].delete_at(0))
            items[2].append(items[i].delete_at(0))
          end
        elsif i == 4
          if el % 3 == 0
            items[2].append(items[i].delete_at(0))
          else
            items[3].append(items[i].delete_at(0))
          end
        elsif i == 5
          if el % 11 == 0
            items[4].append(items[i].delete_at(0))
          else
            items[6].append(items[i].delete_at(0))
          end
        elsif i == 6
          if el % 13 == 0
            items[4].append(items[i].delete_at(0))
          else
            items[3].append(items[i].delete_at(0))
          end
        elsif i == 7
          if el % 19 == 0
            items[1].append(items[i].delete_at(0))
          else
            items[0].append(items[i].delete_at(0))
          end
        end
      end
    end
    #puts round
    #print items
    #puts
    #puts
    #puts
  end
  #print inspections
  #puts
  return inspections.max(2).inject(1) { |prod, i| prod * i }
end

def part2(input)
  inspections = [0, 0, 0, 0, 0, 0, 0, 0]
  items = [[79, 98], [54, 65, 75, 74], [79, 60, 97], [74]]
  monkeys = 4
  items = [[77, 69, 76, 77, 50, 58], [75, 70, 82, 83, 96, 64, 62], [53], [85, 64, 93, 64, 99], [61, 92, 71], [79, 73, 50, 90], [50, 89], [83, 56, 64, 58, 93, 91, 56, 65]]
  monkeys = 8
  for round in 1..10000
    for i in 0...monkeys
      if i == 0
        #items[i] = items[i].map { |j| j * 19 }
        items[i] = items[i].map { |j| j * 11 }
      elsif i == 1
        #items[i] = items[i].map { |j| j + 6 }
        items[i] = items[i].map { |j| j + 8 }
      elsif i == 2
        #items[i] = items[i].map { |j| j * j }
        items[i] = items[i].map { |j| j * 3 }
      elsif i == 3
        #items[i] = items[i].map { |j| j + 3 }
        items[i] = items[i].map { |j| j + 4 }
      elsif i == 4
        items[i] = items[i].map { |j| j * j }
      elsif i == 5
        items[i] = items[i].map { |j| j + 2 }
      elsif i == 6
        items[i] = items[i].map { |j| j + 3 }
      elsif i == 7
        items[i] = items[i].map { |j| j + 5 }
      end
      inspections[i] += items[i].length
      items[i] = items[i].map { |j| j % (5 * 17 * 2 * 7 * 3 * 11 * 13 * 19) }
      while items[i].length != 0
        el = items[i][0]
        if i == 0
          #if el % 23 == 0
          if el % 5 == 0
            #items[2].append(items[i].delete_at(0))
            items[1].append(items[i].delete_at(0))
          else
            #items[3].append(items[i].delete_at(0))
            items[5].append(items[i].delete_at(0))
          end
        elsif i == 1
          #if el % 19 == 0
          if el % 17 == 0
            #items[2].append(items[i].delete_at(0))
            items[5].append(items[i].delete_at(0))
          else
            #items[0].append(items[i].delete_at(0))
            items[6].append(items[i].delete_at(0))
          end
        elsif i == 2
          #if el % 13 == 0
          if el % 2 == 0
            #items[1].append(items[i].delete_at(0))
            items[0].append(items[i].delete_at(0))
          else
            #items[3].append(items[i].delete_at(0))
            items[7].append(items[i].delete_at(0))
          end
        elsif i == 3
          #if el % 17 == 0
          if el % 7 == 0
            #items[0].append(items[i].delete_at(0))
            items[7].append(items[i].delete_at(0))
          else
            #items[1].append(items[i].delete_at(0))
            items[2].append(items[i].delete_at(0))
          end
        elsif i == 4
          if el % 3 == 0
            items[2].append(items[i].delete_at(0))
          else
            items[3].append(items[i].delete_at(0))
          end
        elsif i == 5
          if el % 11 == 0
            items[4].append(items[i].delete_at(0))
          else
            items[6].append(items[i].delete_at(0))
          end
        elsif i == 6
          if el % 13 == 0
            items[4].append(items[i].delete_at(0))
          else
            items[3].append(items[i].delete_at(0))
          end
        elsif i == 7
          if el % 19 == 0
            items[1].append(items[i].delete_at(0))
          else
            items[0].append(items[i].delete_at(0))
          end
        end
      end
    end
    #puts round
    #print items
    #puts
    #puts
    #puts
  end
  #print inspections
  #puts
  return inspections.max(2).inject(1) { |prod, i| prod * i }
end

puts part1(data)
puts part2(data)