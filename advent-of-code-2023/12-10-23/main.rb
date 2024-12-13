require 'set'

day = "10"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    ground = input.map { |i| i.split("") }
    sIndex = nil
    for i in 0...input.length
        for j in 0...input[i].length
            if input[i][j] == 'S'
                sIndex = [i, j]
                break
            end
        end
        break if sIndex
    end
    queue = [[sIndex]]
    while true
        curPath = queue[0]
        curNode = curPath.last
        if curPath.last == sIndex and not curPath.length <= 3
            # print curPath
            # puts
            return curPath.length / 2
        end
        if curPath.length != 1 and curPath.last == sIndex
            queue.shift
            next
        end
        connects = {
            "S" => [[-1, 0], [0, -1], [1, 0], [0, 1]],
            "-" => [[0, 1], [0, -1]],
            "|" => [[1, 0], [-1, 0]],
            "F" => [[0, 1], [1, 0]],
            "J" => [[-1, 0], [0, -1]],
            "7" => [[1, 0], [0, -1]],
            "L" => [[-1, 0], [0, 1]]
        }
        for n in connects[ground[curNode[0]][curNode[1]]]
            checkX = curNode[0] + n[0]
            checkY = curNode[1] + n[1]
            # print [checkX, checkY]
            # puts [checkX, checkY] in curPath
            next if curPath.last(2)[0] == [checkX, checkY]
            # print [checkX, checkY]
            next if (checkX < 0 or checkX >= ground.length or checkY < 0 or checkY >= ground[0].length)
            # print [checkX, checkY]
            if n[0] == -1
                if ["|", "F", "7", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[0] == 1
                if ["|", "J", "L", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[1] == -1
                if ["-", "F", "L", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[1] == 1
                if ["-", "J", "7", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            else
                print n
                puts
                raise 'getNext'
            end
        end
        queue.shift
        # print queue
        # puts
    end
end

def part2(input)
    pipe = nil
    ground = input.map { |i| i.split("") }
    sIndex = nil
    for i in 0...input.length
        for j in 0...input[i].length
            if input[i][j] == 'S'
                sIndex = [i, j]
                break
            end
        end
        break if sIndex
    end
    queue = [[sIndex]]
    count = 0
    while true
        count += 1
        curPath = queue[0]
        curNode = curPath.last
        if curPath.last == sIndex and not curPath.length <= 3
            pipe = curPath
            break
        end
        if curPath.length != 1 and curPath.last == sIndex
            queue.shift
            next
        end
        connects = {
            "S" => [[-1, 0], [0, -1], [1, 0], [0, 1]],
            "-" => [[0, 1], [0, -1]],
            "|" => [[1, 0], [-1, 0]],
            "F" => [[0, 1], [1, 0]],
            "J" => [[-1, 0], [0, -1]],
            "7" => [[1, 0], [0, -1]],
            "L" => [[-1, 0], [0, 1]]
        }
        for n in connects[ground[curNode[0]][curNode[1]]]
            checkX = curNode[0] + n[0]
            checkY = curNode[1] + n[1]
            # print [checkX, checkY]
            # puts [checkX, checkY] in curPath
            next if curPath.last(2)[0] == [checkX, checkY]
            # print [checkX, checkY]
            next if (checkX < 0 or checkX >= ground.length or checkY < 0 or checkY >= ground[0].length)
            # print [checkX, checkY]
            if n[0] == -1
                if ["|", "F", "7", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[0] == 1
                if ["|", "J", "L", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[1] == -1
                if ["-", "F", "L", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            elsif n[1] == 1
                if ["-", "J", "7", "S"].include? ground[checkX][checkY]
                    temp = curPath.clone
                    temp << [checkX, checkY]
                    queue << temp
                end
            else
                print n
                puts
                raise 'getNext'
            end
        end
        queue.shift
        # print queue
        # puts
    end
    return calcArea(pipe)
end

def calcArea(pipe)
    # print pipe
    # puts
    # puts pipe.length
    area = 0
    for i in 0...(pipe.length - 1)
        area += det(pipe.slice(i, 2).transpose)
    end
    return (area.abs / 2) - (pipe.length / 2) + 1
end

def det(matrix)
    return matrix[0][0] * matrix[1][1] - matrix[1][0] * matrix[0][1]
end

puts part1(data)
puts part2(data)