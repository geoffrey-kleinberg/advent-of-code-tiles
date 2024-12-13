day = "13"
file_name = "12-#{day}-23/sampleIn.txt"
file_name = "12-#{day}-23/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def part1(input)
    images = [[]]
    for line in input
        if line == ""
            images.append([])
        else
            images[images.length - 1].append(line)
        end
    end
    sum = 0
    for im in images
        val = checkSymmetry(im)
        if not val
            val = checkSymmetry(im.map { |i| i.split("")}.transpose.map {|i| i.join })
            sum += val
        else
            sum += 100 * val
        end
    end
    return sum
end

def checkSymmetry(im, old=nil)
    for x in 1...im.length
        top = im.slice(0, x)
        bottom = im.slice(x, im.length - x)
        compare = [top.length, bottom.length].min
        if top.reverse.slice(0, compare) == bottom.slice(0, compare)
            if (not old) or (old and x != old)
                return x
            end
        end
    end
    return nil
end

def part2(input)
    images = [[]]
    for line in input
        if line == ""
            images.append([])
        else
            images[images.length - 1].append(line)
        end
    end
    oldLines = {}
    for im in images
        val = checkSymmetry(im)
        if not val
            val = checkSymmetry(im.map { |i| i.split("")}.transpose.map {|i| i.join })
            oldLines[im] = [val, "vertical"]
        else
            oldLines[im] = [val, "horizontal"]
        end
    end
    sum = 0
    for im in images
        val = newSymmetry(im.map { |i| i.split("") }, oldLines[im])
        sum += val
    end
    return sum
end

def newSymmetry(im, oldSymmetry)
    for y in 0...im.length
        for x in 0...im[y].length
            val = nil
            # change im[y][x] to the opposite
            im[y][x] = (im[y][x] == "#") ? "." : "#"

            old = nil
            # check symmetry horizontally
            if oldSymmetry[1] == "horizontal"
                old = oldSymmetry[0]
            end
            val = checkSymmetry(im, old=old)

            # if val is different or old was vertical
            if val and (val != oldSymmetry[0] or oldSymmetry[1] == "vertical")
                return 100 * val
            end
            # return 100 * val

            old = nil
            if oldSymmetry[1] == "vertical"
                old = oldSymmetry[0]
            end
            # check symmetry vertically
            val = checkSymmetry(im.transpose, old=old)
            
            # if val is different or old was horizontal
            # return val
            if val and (val != oldSymmetry[0] or oldSymmetry[1] == "horizontal")
                return val
            end

            im[y][x] = (im[y][x] == "#") ? "." : "#"
        end
    end
    puts val
end

# puts part1(data)
puts part2(data)