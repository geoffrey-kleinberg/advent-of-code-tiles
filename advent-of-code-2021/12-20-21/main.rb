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

def toBinary(string)
  i = string.length
  return string.split("").map { |i| (i == "#") ? 1 : 0 }.inject(0) { |sum, val|
    sum + (val * (2 ** (i -= 1)))
  }
end

def getNeighbors(i, j, image, dots, iMax, jMax)
  neighbors = []
  for a in -1..1
    for b in -1..1
      #puts
      #puts i + a
      #puts j + b
      #puts i + a >= 0 
      #puts i + a < iMax
      #puts j + b >= 0
      #puts j + b < jMax
      if i + a >= 0 and i + a < iMax and j + b >= 0 and j + b < jMax
        #puts image[i + a].slice(j + b)
        neighbors.append(image[i + a].slice(j + b))
      else
        if dots
          neighbors.append(".")
        else
          neighbors.append("#")
        end
      end
    end
  end
  return neighbors
end

def enhance(image, iter, enhancer)
  dots = false
  dots = true if iter % 2 == 0
  oldHeight = image.length
  oldWidth = image[0].length
  newHeight = oldHeight + 2
  newWidth = oldWidth + 2
  newImage = []
  for i in 0...newHeight
    newImage[i] = ""
    for j in 0...newWidth
      neighbors = getNeighbors(i - 1, j - 1, image, dots, oldHeight, oldWidth)
      index = toBinary(neighbors.join)
      newThing = enhancer.slice(index)
      newImage[i] += newThing
    end
  end
  return newImage
end

def part1(input)
  iter = 0
  enhancer = input[0]
  image = []
  for i in 2...input.length
    image << input[i]
  end
  image.each { |i|
    print i
    puts
  }
  #puts
  
  #print getNeighbors(-1, 4, image, true, 4, 4)
  #puts
  2.times {
    image = enhance(image, iter, enhancer)
    image.each { |i|
      print i
      puts
    }
    #puts
    iter += 1
  }
  return image.join.count("#")
end

def part2(input)
  iter = 0
  enhancer = input[0]
  image = []
  for i in 2...input.length
    image << input[i]
  end
  image.each { |i|
    #print i
    #puts
  }
  #puts
  
  #print getNeighbors(-1, 4, image, true, 4, 4)
  #puts
  50.times { |j|
    image = enhance(image, iter, enhancer)
    image.each { |i|
      #print i
      #puts
    }
    #puts
    iter += 1
    puts j
  }
  return image.join.count("#")
end

#puts part1(sinput.clone)
puts part1(input.clone)

#puts

#puts part2(sinput.clone)
puts part2(input.clone)