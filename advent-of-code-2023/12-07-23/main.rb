day = "07"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def getDistinctCounts(hand)
    counts = {}
    for i in hand.split("")
        counts[i] = (counts[i]) ? (counts[i] + 1) : 1
    end
    return counts
end

def getType(hand)
    counts_data = getDistinctCounts(hand)
    counts = counts_data.values
    jokers = counts["J"]
    if counts.include? 5
        return "5"
    elsif counts.include? 4
        return "4"
    elsif counts.include? 3
        if counts.include? 2
            return "FH"
        else
            return "3"
        end
    elsif counts.include? 2
        if counts.count(2) == 2
            return "2p"
        else
            return "1p"
        end
    else
        return "hc"
    end
end

def compare(hand1, hand2)
    #return +1 if hand1 is better
    # return -1 if hand2 is better
    cards = 'AKQJT98765432'.split("")
    order = ["5", "4", "FH", "3", "2p", "1p", "hc"]
    h1Type = getType(hand1)
    h2Type = getType(hand2)
    if order.index(h1Type) < order.index(h2Type)
        return 1
    elsif order.index(h2Type) < order.index(h1Type)
        return -1
    else
        for i in 0...5
            if cards.index(hand1.slice(i)) < cards.index(hand2.slice(i))
                return 1
            elsif cards.index(hand2.slice(i)) < cards.index(hand1.slice(i))
                return -1
            end
        end
    end
    raise "check compare"
    return 0
end

def part1(input)
    hands = input.map { |i| i.split(" ") }
    sorted = hands.sort { |i, j| compare(i[0], j[0]) <=> compare(j[0], i[0]) }
    sum = 0
    for i in 0...sorted.length
        sum += sorted[i][1].to_i * (i + 1)
    end
    return sum
end

def compare2(hand1, hand2)
    cards = 'AKQT98765432J'.split("")
    order = ["5", "4", "FH", "3", "2p", "1p", "hc"]
    h1Type = getType2(hand1)
    h2Type = getType2(hand2)
    if order.index(h1Type) < order.index(h2Type)
        return 1
    elsif order.index(h2Type) < order.index(h1Type)
        return -1
    else
        for i in 0...5
            if cards.index(hand1.slice(i)) < cards.index(hand2.slice(i))
                return 1
            elsif cards.index(hand2.slice(i)) < cards.index(hand1.slice(i))
                return -1
            end
        end
    end
    raise "check compare"
    return 0
end

def getType2(hand)
    counts_data = getDistinctCounts(hand)
    counts = counts_data.values
    if counts.include? 5
        return "5"
    end
    jokers = counts_data["J"]
    if jokers
        counts.delete_at(counts.index(jokers))
        counts[counts.index(counts.max)] += jokers
    end
    if counts.include? 5
        return "5"
    elsif counts.include? 4
        return "4"
    elsif counts.include? 3
        if counts.include? 2
            return "FH"
        else
            return "3"
        end
    elsif counts.include? 2
        if counts.count(2) == 2
            return "2p"
        else
            return "1p"
        end
    else
        return "hc"
    end
end

def part2(input)
    hands = input.map { |i| i.split(" ") }
    sorted = hands.sort { |i, j| compare2(i[0], j[0]) <=> compare2(j[0], i[0]) }
    sum = 0
    for i in 0...sorted.length
        sum += sorted[i][1].to_i * (i + 1)
    end
    return sum
end

# puts part1(data)
puts part2(data)