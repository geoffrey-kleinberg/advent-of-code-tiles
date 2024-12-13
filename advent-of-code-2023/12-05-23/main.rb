file_name = '12-05-23/sampleIn.txt'
file_name = '12-05-23/input.txt'

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    seeds = input[0].split(": ")[1].split(" ").map { |i| i.to_i }
    categories = ['seed', 'soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location']
    idx = 0
    line = 1
    maps = []
    while line < input.length
        if categories[idx + 1] and input[line] == categories[idx] + '-to-' + categories[idx + 1] + ' map:'
            maps << []
            idx += 1
        elsif input[line] != ''
            maps[idx - 1].append(input[line].split(" ").map { |i| i.to_i })
        end
        line += 1
    end
    for mapi in maps
        next_seeds = []
        for i in seeds
            found = false
            for j in mapi
                if i >= j[1] and i < j[1] + j[2]
                    next_seeds.append(j[0] + (i - j[1]))
                    found = true
                end
            end
            if not found
                next_seeds.append(i)
            end
        end
        seeds = next_seeds.clone
    end
    return seeds.min
end

def part2(input)
    seeds = input[0].split(": ")[1].split(" ").map { |i| i.to_i }
    ranges = []
    for i in 0...seeds.length
        if i % 2 == 0
            ranges.append([seeds[i]])
        else
            ranges[ranges.length - 1].append(seeds[i])
        end
    end
    categories = ['seed', 'soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location']
    idx = 0
    line = 1
    maps = []
    while line < input.length
        if categories[idx + 1] and input[line] == categories[idx] + '-to-' + categories[idx + 1] + ' map:'
            maps << []
            idx += 1
        elsif input[line] != ''
            maps[idx - 1].append(input[line].split(" ").map { |i| i.to_i })
        end
        line += 1
    end
    for mapi in maps
        mapi = mapi.sort { |a, b| a[1] <=> b[1] }
        next_ranges = []
        for r1 in ranges
            # inc = 0
            # for r2 in mapi
            #     if r2[1] + r2[2] >= r[0] + inc
            #         if r[0] > r2[1]
            #             dist = -1
            #             if r[0] + r[1] < r2[1] + r2[2]
            #                 dist = r[1]
            #             else
            #                 dist = r2[1] - r[0] + r2[2]
            #             end
            #             next_ranges.append([r2[0] + r[0] - r2[1] + inc, dist])
            #             inc += dist
            #             r[1] -= dist
            #         else
                        
            #     end
            # end
            # if r[1] != 0
            #     next_ranges.append([r[0] + inc, r[1]])
            # end
            for thisMap in mapi
                r2 = [thisMap[1], thisMap[2]]
                #print r1
                #puts
                #print r2
                #puts
                intersect = nil
                if r1[0] < r2[0]
                    if r1[0] + r1[1] > r2[0]
                        if r2[0] + r2[1] > r1[0] + r1[1]
                            intersect = [r2[0], (r1[0] + r1[1] - r2[0])]
                        else
                            intersect = [r2[0], r2[1]]
                        end
                    end
                elsif r1[0] == r2[0]
                    intersect = [r1[0], [r1[1], r2[1]].min]
                else
                    #puts 'here'
                    if r2[0] + r2[1] > r1[0]
                        if r1[0] + r1[1] > r2[0] + r2[1]
                            intersect = [r1[0], r2[0] + r2[1] - r1[0]]
                        else
                            #puts 'here2'
                            intersect = [r1[0], r1[1]]
                            #print intersect
                            #puts
                        end
                    end
                end
                #print "intersect"
                #print intersect
                # puts
                if intersect
                    next_ranges.append([intersect[0] + thisMap[0] - r2[0], intersect[1]])
                    # then r1 becomes the remainder
                    r1min = r1[0]
                    r1max = r1[0] + r1[1]
                    if intersect[0] == r1min
                        r1 = [intersect[0] + intersect[1], r1[1] - intersect[1]]
                    else
                        r1 = [r1[0], r1[1] - intersect[1]]
                        if intersect[0] + intersect[1] <= r1max
                            ranges.append(intersect[0] + intersect[1], r1max - (intersect[0] + intersect[1]))
                        end
                    end
                end
                # print next_ranges
                # puts
            end
            next_ranges.append(r1)
        end
        ranges = next_ranges.filter { |i| i[1] != 0 }.map { |i| i.clone }
        #print ranges
        #puts
    end
    # print ranges
    return ranges.min { |a, b| a[0] <=> b[0] }[0]
end

# puts part1(data)
puts part2(data)