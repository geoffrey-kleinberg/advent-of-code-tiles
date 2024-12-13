input = []
File.open("input.txt") do |f|
	f.each do |i|
		input.append(i)
	end
end
def part1(input)
	x = 0
	y = 0
	facing = 0
	for i in input
		if i.slice(0) == "N" or (i.slice(0) == "F" and facing == 270)
			y += i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "E" or (i.slice(0) == "F" and facing == 0)
			x += i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "S" or (i.slice(0) == "F" and facing == 90)
			y -= i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "W" or (i.slice(0) == "F" and facing == 180)
			x -= i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "L"
			facing -= i.slice(1, i.length - 1).to_i
			facing %= 360
		elsif i.slice(0) == "R"
			facing += i.slice(1, i.length - 1).to_i
			facing %= 360
		end
	end
	return x.abs + y.abs
end
def part2(input)
	x = 0
	y = 0
	wx = 10
	wy = 1
	orientation = 0
	for i in input
		if i.slice(0) == "N"
			wy += i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "E"
			wx += i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "S"
			wy -= i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "W"
			wx -= i.slice(1, i.length - 1).to_i
		elsif i.slice(0) == "L"
			rot = (i.slice(1, i.length - 1).to_i) % 360
			if rot == 90
				tempx = wx
				wx = -1 * wy
				wy = tempx
			elsif rot == 180
				wx *= -1
				wy *= -1
			elsif rot == 270
				tempx = wx
				wx = wy
				wy = -1 * tempx
			end
		elsif i.slice(0) == "R"
			rot = (i.slice(1, i.length - 1).to_i) % 360
			if rot == 270
				tempx = wx
				wx = -1 * wy
				wy = tempx
			elsif rot == 180
				wx *= -1
				wy *= -1
			elsif rot == 90
				tempx = wx
				wx = wy
				wy = -1 * tempx
			end
		elsif i.slice(0) == "F"
			times = (i.slice(1, i.length - 1).to_i)
			x += wx * times
			y += wy * times
		end
	end
	return x.abs + y.abs
end
puts part1(input)
puts part2(input)