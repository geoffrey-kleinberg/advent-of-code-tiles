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

def binToTen(bin)
  pow = bin.length
  return bin.split("").inject(0) { |val, i| val + i.to_i * (2 ** (pow -= 1)) }
end

def part1(input)
  rotated = (input.map { |i| i.split("") }).transpose
  gamma = rotated.map { |i| i.count("1") > i.count("0") ? 1 : 0}
  gammaNum = binToTen(gamma.join())
  eps = rotated.map { |i| i.count("1") > i.count("0") ? 0 : 1}
  epsNum = binToTen(eps.join())
  return gammaNum * epsNum
end

def part2(input)
  nums = {
    "o" => input.clone,
    "c" => input.clone
  }
  for bit in 0...input[0].length
    bits = {
      "o" => nums["o"].map { |i| i[bit] },
      "c" => nums["c"].map { |i| i[bit] }
    }
    deleteOnes = {
      "o" => bits["o"].count("0") > bits["o"].count("1"),
      "c" => bits["c"].count("1") >= bits["c"].count("0")
    }
    nums["o"].delete_if { |i| (deleteOnes["o"]) ? (i[bit] == "1") : (i[bit] == "0") } if nums["o"].length != 1
    nums["c"].delete_if { |i| (deleteOnes["c"]) ? (i[bit] == "1") : (i[bit] == "0") } if nums["c"].length != 1
  end
  return binToTen(nums["o"][0]) * binToTen(nums["c"][0])
end

puts part1(sinput)
puts part1(input)

puts

puts part2(sinput)
puts part2(input)