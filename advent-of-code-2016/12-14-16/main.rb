require 'set'
require 'digest'

day = "14"
file_name = "12-#{day}-16/sampleIn.txt"
# file_name = "12-#{day}-16/input.txt"

data = File.read(file_name).split("\n").map { |i| i.strip }

def hasTriple(hash)
  h = hash.split("")
  for i in 0...(h.length - 2)
    if h[i] == h[i + 1] and h[i] == h[i + 2]
      return h[i]
    end
  end
  return nil
end

def hasQuint(hash)
  h = hash.split("")
  quints = []
  for i in 0...(h.length - 4)
    if h[i] == h[i + 1] and h[i] == h[i + 2] and h[i] == h[i + 3] and h[i] == h[i + 4]
      quints.append(h[i])
    end
  end
  if quints.length >= 1
    return quints
  end
  return nil
end

def part1(input)
  input = "yjdafjpo"
  # input = "abc"

  triples = {}

  validKeys = []

  md5 = Digest::MD5.new

  num = 0
  after64 = 0
  while validKeys.length < 64 and after64 <= 1000
    # puts num
    md5.reset
    md5.update(input + num.to_s)
    hash = md5.hexdigest

    trip = hasTriple(hash)
    if trip
      triples[num] = trip
    end

    quints = hasQuint(hash)
    if quints
      for k, v in triples
        next if num - 1000 > k or k >= num
        
        if quints.include? v
          validKeys.append(k)
        end
      end
    end

    if validKeys.length >= 64
      after64 += 1
    end

    num += 1
  end

  return validKeys.sort[63]
end

def part2(input)
  input = "yjdafjpo"
  # input = "abc"

  triples = {}

  validKeys = []

  md5 = Digest::MD5.new

  num = 0
  after64 = 0
  while validKeys.length < 64 and after64 <= 1000
    # puts num
    md5.reset
    md5.update(input + num.to_s)
    hash = md5.hexdigest

    2016.times {
      md5.reset
      md5.update(hash)
      hash = md5.hexdigest
    }

    trip = hasTriple(hash)
    if trip
      triples[num] = trip
    end

    quints = hasQuint(hash)
    if quints
      for k, v in triples
        next if num - 1000 > k or k >= num
        
        if quints.include? v
          validKeys.append(k)
        end
      end
    end

    if validKeys.length >= 64
      after64 += 1
    end

    num += 1
  end

  return validKeys.sort[63]
end

# puts part1(data)
puts part2(data)